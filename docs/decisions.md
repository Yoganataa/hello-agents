# Decisions

Append-only log. Add an entry whenever scope, status, stack, or a contract
changes. This is how one person plays owner and developer without silently
rewriting the rules: you may override the baseline, but in writing.

## Template

```
### YYYY-MM-DD  Short title
- Decision:
- Why (evidence, not preference):
- Trade-off: cut X / adds N days / costs Y
- Changes: product.md status | scope | architecture | other
```

## Log

### YYYY-MM-DD  Project started
- Decision: Status set to `hypothesis`.
- Why: Nothing validated yet.
- Trade-off: none.
- Changes: product.md status.
