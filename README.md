# hello-agents

A zero-maintenance `AGENTS.md` + `docs/` boilerplate for AI coding agents across **web**, **mobile**, **desktop**, **bot**, and **database** projects.

Instead of vendoring heavy rulesets into your repository, you only maintain your project's own contract (`AGENTS.md` and `docs/`). External skill kits are installed on demand via `npx skills add` and routed from `AGENTS.md`.

## Install

Run from the root of your project. Existing files are skipped by default.

**macOS / Linux:**

```sh
curl -fsSL https://raw.githubusercontent.com/Yoganataa/hello-agents/main/install.sh | sh
```

**Windows (PowerShell):**

```powershell
irm https://raw.githubusercontent.com/Yoganataa/hello-agents/main/install.ps1 | iex
```

To overwrite existing files:

- **macOS / Linux:** `curl -fsSL https://raw.githubusercontent.com/Yoganataa/hello-agents/main/install.sh | sh -s -- --force`
- **Windows:** `& ([scriptblock]::Create((irm https://raw.githubusercontent.com/Yoganataa/hello-agents/main/install.ps1))) -Force`

## How it works

1. **Install the boilerplate** — The shell script downloads `AGENTS.md` and `docs/` into your project without requiring Node.js, Python, or any package manager.
2. **Fill in project facts** — Update `AGENTS.md` (platform, stack, commands, non-negotiable rules), `docs/product.md`, and `docs/architecture.md`. Remove unused sections from `docs/skills.md` and `docs/stack-notes.md`.
3. **Install external kits on demand** — Pick only the skill kits your stack needs from [docs/skills.md](docs/skills.md) using `npx skills add <owner/repo>`.
4. **Automatic behavior routing** — When an AI agent opens the project, it reads `AGENTS.md`, detects the stack from manifest files, loads any installed skills for that task, and falls back to `docs/` when a kit isn't installed.

## What's included

| File | Purpose |
|---|---|
| `AGENTS.md` | Project overview, commands, rules that bite, working agreement, behavior routing, and delivery gate |
| `docs/product.md` | Problem, evidence, success criteria, scope baseline, Definition of Done, and a status that gates what agents may build |
| `docs/ideas.md` | Parking lot for new ideas so they don't leak into the current work |
| `docs/decisions.md` | Append-only log of scope, status, and stack changes with their trade-offs |
| `docs/architecture.md` | Runtime constraints, database/migrations, API/IPC contracts, auth, and deploy notes |
| `docs/naming-and-copy.md` | Naming conventions, code comment hygiene, and user-facing copy rules |
| `docs/skills.md` | Curated catalog of install-on-demand skill kits per stack |
| `docs/stack-notes.md` | Practical guardrails for stacks without a dedicated external kit (Telegram bots, Tauri v2, Electron, SQLite) |
| `docs/quality.md` | Stack-specific test quality rules, CI pipeline stages, database testing, and PR test guard |
| `docs/reports/TEMPLATE.md` | End-of-task report template capturing scope, command evidence, test diffs, and unverified gaps |
| `docs/evals.md` | Report-audit rubric (cross-check real task reports against `git diff` and CI) plus optional synthetic spot-checks |

## What a prompt file can and can't do

`AGENTS.md` lowers how often an agent drifts; it can't enforce anything. Pair it with [docs/quality.md](docs/quality.md) (CI pipeline, branch protection, and a PR test guard that catches deleted/skipped tests and empty catches), plus a human who reads what they approve. Rather than running manual evals every day, agents write a short report from [docs/reports/TEMPLATE.md](docs/reports/TEMPLATE.md) at the end of each task so you—or a fresh auditor session—can cross-check real work against `git diff` and CI using [docs/evals.md](docs/evals.md).

## Supported agents

`AGENTS.md` is an open format read by most modern AI coding agents, including:

- **Antigravity**
- **OpenAI Codex**
- **Cursor**
- **Windsurf**
- **GitHub Copilot**
- **Cline**
- **OpenCode**
- **Gemini CLI** & **Claude Code** (also compatible with `npx skills add`)

## Credits

- **AGENTS.md** open specification for cross-agent project instructions.
- **[skills.sh](https://skills.sh)** & **Vercel Labs (`skills` CLI)** for the open `npx skills add` ecosystem.
- **tgcloud** for inspiring the concise `AGENTS.md` + on-demand `docs/` structure.
- All official framework teams and open-source maintainers whose skill kits are cataloged in [docs/skills.md](docs/skills.md).
