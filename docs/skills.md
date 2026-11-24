# Skill kits (install on demand)

External kits are **not** vendored into this repo. Install the ones the project
needs; their maintainers keep them current. Delete rows for stacks this project
doesn't use.

```
npx skills add <owner/repo>              # into this project
npx skills add <owner/repo> -g           # user-wide, all projects
npx skills add <owner/repo> --list       # browse skills inside a repo first
npx skills add <owner/repo> --skill <name>
npx skills find <query>                  # search skills.sh
```

Trust levels: **official** = maintained by the framework/vendor team.
**community** = third party; read the SKILL.md before installing, it runs as
instructions inside your agent.

Repos checked to exist on 2026-11-24.

## Core (every project)

| Kit | Install | Why |
|-----|---------|-----|
| Anti-slop | `npx skills add miqdadbadjuber/anti-slop` | Filters generic AI UI, copy, comments, mobile layout |
| Engineering workflow | `npx skills add addyosmani/agent-skills` | Spec, planning, TDD, code review, quality gates |
| Security review | `npx skills add trailofbits/skills` | Audit-style checks for auth, crypto, unsafe input |

## Web

| Stack | Install | Trust |
|-------|---------|-------|
| Svelte / SvelteKit | `npx skills add sveltejs/ai-tools` (also ships the Svelte MCP) | official |
| Next.js | `npx skills add vercel-labs/next-skills` | official |
| React / Next perf + UI audit | `npx skills add vercel-labs/agent-skills` | official |
| Hono | `npx skills add honojs/skills` | official |
| Tailwind | no official kit; covered by `antislop-ui` + `jakubkrehel/skills` | — |
| UI polish (type, motion, a11y) | `npx skills add jakubkrehel/skills` | community |
| Web vitals, WCAG, SEO | `npx skills add addyosmani/web-quality-skills` | community |
| E2E tests | `npx skills add microsoft/playwright-cli` | official |
| Cloudflare Workers (Hono deploy) | `npx skills add cloudflare/skills` | official |

## Mobile

| Stack | Install | Trust |
|-------|---------|-------|
| Kotlin + Jetpack Compose | `npx skills add android/skills` (or `android skills` via the Android CLI) | official |
| Kotlin / KMP | `npx skills add Kotlin/kotlin-agent-skills` | official |
| Kotlin tooling (Gradle, IDE) | `npx skills add JetBrains/skills` | official |
| Flutter | `npx skills add flutter/skills` | official |
| React Native | `npx skills add callstackincubator/agent-skills` | community (Callstack) |
| Expo | `npx skills add expo/skills` | official |
| Capacitor | `npx skills add ionic-team/capacitor-skills` | official |
| Capacitor plugins | `npx skills add capawesome-team/skills` | community |
| Tauri v2 mobile | see Desktop → Tauri | — |

## Desktop

| Stack | Install | Trust |
|-------|---------|-------|
| Tauri v2 | no official kit; `full-stack-skills/tauri-skills` exists but is small. Use [stack-notes.md](stack-notes.md) | community |
| Electron | no official kit; `jwynia/agent-skills --list` has Electron guidance. Use [stack-notes.md](stack-notes.md) | community |

## Bot (Telegram)

No official kit for kurigram, aiogram, mtcute, grammY, or gotd. Rules live in
[stack-notes.md](stack-notes.md). Search periodically:

```
npx skills find telegram
```

| Language | Install | Trust |
|----------|---------|-------|
| Go (for gotd projects) | `npx skills add samber/cc-skills-golang` | community |

## Database

| DB | Install | Trust |
|----|---------|-------|
| PostgreSQL | `npx skills add supabase/agent-skills` (Postgres best practices) | official (Supabase) |
| PostgreSQL (serverless) | `npx skills add neondatabase/agent-skills` | official (Neon) |
| MySQL / Postgres | `npx skills add planetscale/skills` | official (PlanetScale) |
| MongoDB | `npx skills add mongodb/agent-skills` | official |
| Prisma ORM | `npx skills add prisma/skills` | official |
| SQLite | no kit; see [stack-notes.md](stack-notes.md) | — |
