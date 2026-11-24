# Stack notes

Rules for stacks without a solid external skill kit. Keep each entry to things an
agent gets wrong without being told. Delete sections this project doesn't use.
When a good kit appears in [skills.md](skills.md), drop the matching section here.

## Telegram bots (all libraries)

- Bot API limits: about 1 message/s per chat, 20/min per group, 30/s overall. On `429`, sleep `retry_after` and retry; don't hammer.
- Always answer a callback query (even with no text), or the button spins until it times out.
- `callback_data` max 64 bytes. Use short `domain:action:id` keys and store bigger state server-side.
- Text max 4096 chars, caption max 1024. Split or truncate deliberately.
- HTML parse mode: escape `<`, `>`, `&` in every user-supplied value.
- Webhooks: acknowledge fast, process slow work in a queue. Telegram retries on timeout, so dedupe by `update_id`.
- Bot tokens, `api_id`/`api_hash`, and MTProto session strings come from env/secret store only. A session string is full account access: never log it, never commit it.

### MTProto clients (kurigram, mtcute, gotd)

- `FLOOD_WAIT_X` means wait X seconds. Respect it; never retry in a tight loop.
- Userbots act as a real account. Bulk join/send/scrape gets the account limited or banned.
- Cache access hashes/peers; resolving usernames repeatedly triggers flood waits.

### Per library

- **aiogram 3:** use `Router` + filters, not the v2 `Dispatcher` decorators. FSM storage must be Redis (or similar) in production; memory storage loses state on restart. Never call blocking I/O inside handlers.
- **kurigram:** Pyrogram fork; the Pyrogram API applies. Check kurigram's changelog before using a Pyrogram snippet from old posts.
- **grammY:** register `bot.catch` so one bad update can't kill the bot. Use `@grammyjs/auto-retry` and `@grammyjs/transformer-throttler` for limits, `@grammyjs/runner` for concurrent long polling. Runs on Node, Bun, Deno, and Workers.
- **mtcute:** pick the runtime package that matches the project (`@mtcute/node` or `@mtcute/bun`). Use its dispatcher for update handling instead of raw update loops.
- **gotd:** wrap the client with `floodwait` and `ratelimit` middleware from `gotd/contrib`. Pass `context.Context` everywhere and cancel on shutdown.

## Tauri v2

- v1 docs and the `allowlist` are obsolete. Permissions live in `src-tauri/capabilities/*.json`; a command or plugin not granted there fails at runtime.
- Each plugin is a Rust crate plus a `@tauri-apps/plugin-*` JS package, and needs its permission added to a capability.
- Commands: `#[tauri::command]`, registered in `tauri::generate_handler![]`. JS sends camelCase args, Rust receives snake_case.
- Make heavy commands `async`; sync commands run on the main thread and freeze the UI.
- Mobile shares `src-tauri/src/lib.rs` with `#[cfg_attr(mobile, tauri::mobile_entry_point)]`. Not every desktop plugin supports Android/iOS; check before using.

## Electron

- Keep `contextIsolation: true`, `nodeIntegration: false`, `sandbox: true`.
- Expose a narrow API through `contextBridge` in preload. Never expose `ipcRenderer` itself.
- In `ipcMain.handle`, validate the sender and every argument; treat the renderer as untrusted.
- Set a CSP. Validate URLs before `shell.openExternal`. Never load remote content into a window with Node access.

## SQLite

- Per connection: `PRAGMA journal_mode=WAL`, `PRAGMA busy_timeout=5000`, and `PRAGMA foreign_keys=ON` (off by default).
- One writer at a time. Serialize writes through one connection or a queue.
- `ALTER TABLE` is limited; bigger changes use the create-copy-drop-rename migration pattern.
- Always use parameterized queries.
