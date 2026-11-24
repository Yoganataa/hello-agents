# AGENTS.md

Orientation for AI coding agents (and humans) working in this project. Keep it
short and true. Project facts live in `docs/`; general best practices come from
external skill kits installed on demand (see [docs/skills.md](docs/skills.md)).

## What this project is

<!-- 2-3 sentences: what it does, who uses it, where it runs. -->

- **Platform:** <!-- web | mobile | desktop | bot (pick, can be several) -->
- **Stack:** <!-- e.g. SvelteKit + Hono + Tailwind + PostgreSQL -->
- **Runtime/deploy target:** <!-- e.g. Cloudflare Workers, Android, Tauri v2, VPS + systemd -->

## Layout

| Path | What it is |
|------|------------|
| `src/` | <!-- app code --> |
| `docs/` | Project reference for agents. Not deployed. |

## Commands

```
# install:
# dev:
# test:
# lint/typecheck:
# build/deploy:
```

Run test + lint/typecheck before saying a task is done. If a command is missing
here, ask instead of guessing.

## Rules that bite

<!-- Only rules an agent gets wrong without being told. Delete examples that don't apply. -->

- Follow [docs/naming-and-copy.md](docs/naming-and-copy.md) for names and every user-facing string.
- Read [docs/architecture.md](docs/architecture.md) before touching DB schema, API/IPC contracts, auth, or deploy config.
- Never commit secrets, bot tokens, MTProto sessions, keystores, or `.env` files.
- Schema changes go through migrations, never by editing a live database by hand.
- Don't add a dependency when the platform or an existing one already covers it.

## Working agreement

Read [docs/product.md](docs/product.md) first: its **Status** decides what work is allowed.

- **Ask, don't guess.** If the task is ambiguous or you may have misread it, ask before changing anything.
- **Stay in scope.** Do only what was asked. A new idea goes into [docs/ideas.md](docs/ideas.md), then return to the task. Never build it unprompted.
- **Scope changes need a trade-off.** Anything outside the baseline in `product.md` needs a [docs/decisions.md](docs/decisions.md) entry naming what is cut, delayed, or paid for. Stop and ask; don't build it silently.
- **No flattery.** If the user is wrong, say so with evidence. Skip openers like "You're right" and "I understand your frustration".
- **Be brief.** Lead with the answer. No recap of what the user said, no filler.
- **Verify, don't recall.** For APIs, library versions, and anything that changes over time, check current docs or the installed version first. If you didn't check, say so.
- **Never fake a pass.** Don't weaken or delete tests, lower assertions, add `.skip`, or add empty `catch` blocks to get green. If a test can't pass, report it with the output.
- **"Works" means you ran it.** Only claim success after running the relevant command, and show the result. Otherwise say it is untested.
- **Review in a separate context.** Use a sub-agent or fresh session to review your own work when the harness allows; if not, say the review is not independent.
- **Parallelize.** When the harness supports sub-agents, split independent work across them.
- **Humans approve at gates.** Stop and ask before: changing status or scope, deleting data, adding dependencies, or deploying.

## Behavior routing

Before starting a task, identify the stack from the manifest files, then load the
matching skills **if installed**. If a skill is not installed, continue with the
fallback rules in `docs/` and mention the missing kit once in your reply. Never
install kits yourself unless asked.

| Task touches | Load first |
|--------------|-----------|
| UI, layout, user-facing copy, code comments | `antislop` core + the matching `antislop-*` skill |
| Vague idea, new product, unclear requirements | `brainstorming` (superpowers), `idea-refine` / `interview-me` (agent-skills) |
| New feature, refactor | `spec-driven-development`, `planning-and-task-breakdown`, `test-driven-development` |
| Bug with unclear cause | `systematic-debugging` (superpowers) or `debugging-and-error-recovery` |
| About to say "done" | `verification-before-completion` (superpowers) |
| Review, or splitting parallel work | `requesting-code-review`, `subagent-driven-development`, `dispatching-parallel-agents` |
| Using an API or library that may have changed | `source-driven-development` (agent-skills) |
| Anything platform-specific | The stack row in [docs/skills.md](docs/skills.md) |
| Tests, CI pipeline, or PR test guard | [docs/quality.md](docs/quality.md) |
| Area with no good external kit (bots, Tauri, Electron) | [docs/stack-notes.md](docs/stack-notes.md) |
| Security-sensitive code (auth, payments, crypto, IPC) | `trailofbits` skills if installed |

Stack detection hints: `svelte.config.*`, `next.config.*`, `hono` in deps,
`build.gradle.kts`, `pubspec.yaml`, `capacitor.config.*`, `src-tauri/`,
`electron` in deps, `app.json`/`metro.config.*`, `pyproject.toml`, `go.mod`,
`bun.lock*`.

## Delivery gate

All must be true before reporting done:

- [ ] Tests and lint/typecheck pass (or the reason they can't run is stated).
- [ ] The change is inside the baseline scope in `docs/product.md`; anything else went to `docs/ideas.md`.
- [ ] Every "works" claim was backed by a command I ran, with output shown.
- [ ] No test was weakened, skipped, or deleted to get green.
- [ ] User-facing text follows `docs/naming-and-copy.md`: one language, no filler, actionable errors.
- [ ] No decorative comments, step narration, vague TODOs, or dead code left behind.
- [ ] No new secret, debug log, or commented-out block committed.
- [ ] `docs/` updated if a contract, command, or rule above changed.
- [ ] End-of-task report written from [docs/reports/TEMPLATE.md](docs/reports/TEMPLATE.md) to `docs/reports/YYYY-MM-DD-<short-slug>.md` (or inline `Evidence` in the reply for tiny/no-logic edits).
