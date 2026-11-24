# Task report template

Agents copy this to `docs/reports/YYYY-MM-DD-<short-slug>.md` at the end of any
task that changed files, fill every field, and link it in the final reply.
Questions and tiny edits (one file, no logic change) skip the file and put the
**Evidence** section in the reply instead.

Write facts that can be checked against git and CI. "Should work" is not a fact.
An empty or "none" field must be true, not a default.

```markdown
# <Task title>

- Date:
- Agent + model:
- Product status at start: hypothesis | validated | building | frozen
- Result: done | partial | blocked

## Task as understood
<One or two sentences. If you asked clarifying questions, list them and the answers.>

## Scope
- Files changed: <list, or "see commit <sha>">
- Outside the baseline in product.md: none | <what, and the decisions.md entry>
- Ideas parked in ideas.md: none | <list>

## Evidence
| Command | Exit code | Result |
|---------|-----------|--------|
| <e.g. npm test> | 0 | 42 passed, 0 failed (was 40) |

## Test changes
- Added:
- Modified (say how):
- Deleted / skipped / assertions weakened: none | <each one and why>

## Sources checked
<Docs, changelogs, or installed versions used for API/library claims. "From memory" if not checked.>

## Not verified
<What you could not run or confirm, and why. Never empty when something was skipped.>

## Review
independent (sub-agent / fresh session / PR reviewer) | self only

## Rule deviations
none | <which Working agreement rule was not followed, and why>

## Needs a human
none | <decisions, approvals, or risky follow-ups>
```
