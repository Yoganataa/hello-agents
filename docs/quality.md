# Quality: tests and CI

How tests and CI should look in this project. When asked to add tests or set up
CI, follow this file and the project's commands in `AGENTS.md`. Delete stack rows
you don't use. Assumes GitHub Actions; translate the stages for other CI.

## Test quality rules

- Test behavior through the public surface (HTTP route, handler, component, command), not private internals.
- Every test asserts something meaningful. A test with no assertion, or one that only checks "no throw", is not a test.
- Use real dependencies where cheap: a real database in a container beats a mocked repository. Mock only the network edge (Telegram API, payment provider, third-party HTTP).
- One bug fix = one regression test that fails before the fix and passes after.
- Coverage is a floor, not a goal. Don't write tests to raise a number.
- Flaky tests get fixed or quarantined with an entry in `docs/ideas.md`; never silently retried until green.
- Tests never need secrets or a live Telegram/production account. CI must pass on a fork.

## CI pipeline

Stages, in order. Each must fail the build on error.

1. **Install from the lockfile** (`npm ci`, `pnpm install --frozen-lockfile`, `bun install --frozen-lockfile`, `uv sync --locked`, `flutter pub get --enforce-lockfile`, `go mod download`). Cache dependencies.
2. **Format check** (no auto-fix in CI).
3. **Lint + typecheck.**
4. **Unit tests.**
5. **Integration tests** against real services (database service containers).
6. **Migrations** applied from an empty database.
7. **Build** the shippable artifact.
8. **Test guard** (below).
9. **E2E** on main branch or nightly if it is slow.

Repository settings (manual, once): protect `main`, require the CI checks to pass, require a PR. Without this, CI is advice.

## Test guard

Fails a PR that weakens tests. Add as a CI step; it needs `actions/checkout` with `fetch-depth: 0`.

```yaml
- name: Test guard
  if: github.event_name == 'pull_request'
  shell: bash
  run: |
    base="origin/${{ github.base_ref }}"
    deleted=$(git diff --name-only --diff-filter=D "$base"...HEAD | grep -Ei '(^|/)(tests?|__tests__|specs?|androidTest)/|[._](test|spec)\.[a-z]+$|_test\.(go|py|dart)$|(^|/)test_[^/]*\.py$' || true)
    added=$(git diff -U0 "$base"...HEAD | grep -E '^\+' | grep -E '\.(skip|only)\(|\bx(it|describe|test)\(|@pytest\.mark\.(skip|xfail)|\bt\.Skip\(|@Ignore|@Disabled|skip: *true|catch *\([^)]*\) *\{ *\}|except[^:]*: *pass' || true)
    if [ -n "$deleted" ] || [ -n "$added" ]; then
      echo "Deleted test files:"; echo "$deleted"
      echo "Skips or empty catches added:"; echo "$added"
      echo "If intended, record it in docs/decisions.md and get the PR approved by a human."
      exit 1
    fi
```

A legitimate removal (dead feature) still fails the guard; the human approves it
by overriding the check with a decisions.md entry. That friction is the point.

## Per stack

| Stack | Format / lint / types | Unit / integration | E2E | CI notes |
|-------|----------------------|--------------------|-----|----------|
| SvelteKit | Prettier, ESLint + `eslint-plugin-svelte`, `svelte-check` | Vitest + `@testing-library/svelte` | Playwright | Run `svelte-kit sync` before `svelte-check` |
| Next.js | Prettier, ESLint with `eslint-config-next` (call ESLint directly), `tsc --noEmit` | Vitest or Jest + React Testing Library | Playwright | Test Server Actions and route handlers as functions |
| Hono | Prettier or Biome, `tsc --noEmit` | Vitest; call `app.request()` instead of starting a server | — | On Workers use `@cloudflare/vitest-pool-workers` |
| Tailwind | `prettier-plugin-tailwindcss` | — | Visual checks via Playwright screenshots if needed | — |
| Kotlin + Compose | ktlint or detekt, Android Lint (`./gradlew lint`) | JUnit, Robolectric, Compose UI test (`createComposeRule`) | Instrumented tests on emulator | `reactivecircus/android-emulator-runner`; screenshot tests with Roborazzi or Paparazzi |
| Kotlin Multiplatform | ktlint or detekt | `kotlin.test` in `commonTest`, `./gradlew allTests` | — | iOS targets need a macOS runner |
| Capacitor | Lint/test the web layer as its framework | Vitest for web logic | Appium or WebdriverIO on device (optional) | `npx cap sync`, then build Android with Gradle, iOS on macOS |
| React Native / Expo | ESLint, `tsc --noEmit` | Jest + `@testing-library/react-native` | Maestro or Detox | Expo: EAS Build for native artifacts |
| Flutter | `dart format --set-exit-if-changed .`, `flutter analyze` | `flutter test`, golden tests | `integration_test` | Pin the Flutter version in CI |
| Tauri v2 | Frontend tools + `cargo fmt --check`, `cargo clippy -- -D warnings` | Frontend tests + `cargo test` | WebdriverIO + `tauri-driver` (Linux/Windows) | Linux needs `libwebkit2gtk-4.1-dev`; build with `tauri-apps/tauri-action` |
| Electron | ESLint, `tsc --noEmit` | Vitest for main and renderer logic | Playwright `_electron` | Linux runner needs `xvfb-run`; test IPC handlers directly |
| Python bots (aiogram, kurigram) | `ruff format --check`, `ruff check`, mypy or pyright | pytest + pytest-asyncio; feed `Update` objects through the dispatcher with a fake bot session | — | Never call Telegram from CI |
| Node/Bun bots (grammY, mtcute) | Biome or ESLint + Prettier, `tsc --noEmit` | Vitest or `bun test`; grammY: `bot.handleUpdate()` with an API transformer that records calls | — | mtcute: keep logic out of the client so it tests without MTProto |
| Go bots (gotd) | `gofmt -l`, `go vet`, golangci-lint | `go test -race ./...`; mock the invoker (`tgmock` in gotd/td) | — | Run with `-race` in CI |

## Databases in CI

| DB | How |
|----|-----|
| PostgreSQL / MySQL / MongoDB | GitHub Actions `services:` container, same major version as production; or Testcontainers |
| SQLite | Temp file per test run (not only `:memory:`, which hides WAL and locking behavior) |

Apply migrations from scratch on every run, then run integration tests against the
result. A migration that only works on your local database is a bug.

## Optional, when the project is mature

- Mutation testing to check that tests catch real bugs: StrykerJS (JS/TS), mutmut (Python), Pitest (JVM).
- Dependency and secret scanning: Dependabot or Renovate, plus GitHub secret scanning.
