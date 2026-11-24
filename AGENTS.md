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

## Behavior routing

Before starting a task, identify the stack from the manifest files, then load the
matching skills **if installed**. If a skill is not installed, continue with the
fallback rules in `docs/` and mention the missing kit once in your reply. Never
install kits yourself unless asked.

| Task touches | Load first |
|--------------|-----------|
| UI, layout, user-facing copy, code comments | `antislop` core + the matching `antislop-*` skill |
| New feature, refactor, bug with unclear cause | `agent-skills` (spec → plan → TDD → review) |
| Anything platform-specific | The stack row in [docs/skills.md](docs/skills.md) |
| Area with no good external kit (bots, Tauri, Electron) | [docs/stack-notes.md](docs/stack-notes.md) |
| Security-sensitive code (auth, payments, crypto, IPC) | `trailofbits` skills if installed |

Stack detection hints: `svelte.config.*`, `next.config.*`, `hono` in deps,
`build.gradle.kts`, `pubspec.yaml`, `capacitor.config.*`, `src-tauri/`,
`electron` in deps, `app.json`/`metro.config.*`, `pyproject.toml`, `go.mod`,
`bun.lock*`.

## Delivery gate

All must be true before reporting done:

- [ ] Tests and lint/typecheck pass (or the reason they can't run is stated).
- [ ] User-facing text follows `docs/naming-and-copy.md`: one language, no filler, actionable errors.
- [ ] No decorative comments, step narration, vague TODOs, or dead code left behind.
- [ ] No new secret, debug log, or commented-out block committed.
- [ ] `docs/` updated if a contract, command, or rule above changed.
