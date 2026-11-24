# Naming and copy

Naming rules for code and the house style for every user-facing string. This is
also the fallback filter when the `antislop` kit isn't installed.

## Names

Follow the language's own convention first; these fill the gaps.

| Kind | Convention | Example |
|------|-----------|---------|
| Folders | `kebab-case`, named by domain | `billing/`, `media/` |
| Files (JS/TS) | `kebab-case` | `job-queue.ts` |
| Files (Kotlin/Dart/Go/Python) | language default | `JobQueue.kt`, `job_queue.dart`, `job_queue.go`, `job_queue.py` |
| Actions | verb + noun | `createJob`, `cancel_job` |
| Booleans | `is` / `has` / `can` / `should` | `isOwner`, `has_access` |
| Types / classes | `PascalCase` | `UploadResult` |
| Constants | `UPPER_SNAKE_CASE` | `MAX_RETRIES` |
| Bot callback data | `domain:action:arg` lowercase | `note:view:12` |
| Tests | framework default | `*.test.ts`, `*_test.go`, `test_*.py` |

- No `utils/`, `helpers/`, `misc/`, or `common/` dumping grounds. Name the domain.
- No vague module-level names like `data`, `handle`, `process`, `res`.
- Framework-mandated layouts (SvelteKit `routes/`, Next `app/`, Tauri `src-tauri/`, Android `res/`) override these rules.

## Code comments

- Comment why, not what. One line, two only if the second is a new fact.
- Keep: business rules, workarounds, edge cases, security and performance notes, protocol details.
- Remove: banners (`// ==== AUTH ====`), step narration (`// Step 1`), restating the next line, emoji, end markers, vague `TODO: improve`.

## User-facing copy

<!-- Set the project language. -->
- **Language:** <!-- id | en --> — one language per screen, no mixing.
- **Tone:** plain and direct. Talk like the app's owner, not a marketing page.

Rules:

1. **Buttons:** 1–3 words, start with a verb. `Simpan`, `Hapus`, `Coba Lagi` / `Save`, `Delete`, `Try again`.
2. **Errors:** say what happened and what to do next. `Koneksi terputus. Periksa internet lalu coba lagi.` Never show raw stack traces or `Something went wrong`.
3. **Empty states:** say how to fill it. `Belum ada catatan. Kirim teks atau foto untuk mulai.`
4. **Emoji:** status markers only (`✅ ⏳ ⚠️ ❌`). None in buttons by default, never one per line.
5. **Consistent terms:** pick one word per concept and reuse it.

| Concept | id | en |
|---------|----|----|
| Refresh | Segarkan | Refresh |
| Back | Kembali | Back |
| Cancel | Batal | Cancel |
| Edit | Ubah | Edit |
| Delete | Hapus | Delete |
| Pagination | ‹ Sebelumnya / Berikutnya › | ‹ Previous / Next › |

Banned filler (any language): "seamless", "unlock", "elevate", "powerful",
"revolutionary", "dive in", "Let's get started!", "Oops!", stacked exclamation
marks, and decorative emoji bullet lists.
