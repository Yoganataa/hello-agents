# Product

Source of truth for what we are building and whether it is ready to build. Agents
read **Status** first; it decides what work is allowed.

## Status

<!-- Exactly one. Change it only with a line in decisions.md. -->
`hypothesis`

| Status | Meaning | Agent may |
|--------|---------|-----------|
| `hypothesis` | Problem or solution not yet validated with real users | Research, interview, prototype, throwaway spikes. No production features. |
| `validated` | Evidence says the problem is real and the solution fits | Plan and spec the in-scope work. |
| `building` | Scope is baselined | Implement in-scope items only. |
| `frozen` | Feature freeze before a release | Fix bugs only. New work goes to `ideas.md`. |

## Problem

<!-- Who has it, what happens today, why it hurts. One short paragraph. -->

## Evidence

<!-- What shows the problem is real: interviews, usage data, support requests, your own repeated pain.
"It sounds good" is not evidence. If this is empty, status stays `hypothesis`. -->

## Success criteria

<!-- Measurable, with a number and a date where possible.
- 10 weekly active users by <date>
- Export finishes in under 5 s for 1000 rows
-->

## Scope

**In** (the baseline; changing it needs a decisions.md entry):

-

**Out / non-goals** (explicitly not now):

-

## Definition of Done

A change is done when all hold:

- [ ] Meets its acceptance criteria in the spec or task.
- [ ] Tests pass and were actually run; output shown.
- [ ] Delivery gate in `AGENTS.md` is clean.
- [ ] `docs/` updated if a contract or rule changed.

## Good enough

<!-- The line where we stop polishing and ship. Without this, nothing ships.
Example: "Works on Android 10+, handles offline, no animations required." -->
