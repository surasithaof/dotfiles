# Code style

- Prefer short, clear identifiers over long descriptive ones (`cutoff` not
  `notificationRetentionCutoffTime`). Name for what it is, not everything about how it's used.
- Tests: table-driven by default — a `cases` slice plus one loop — rather than repeated
  hand-written per-case blocks, whenever the language/test framework supports it. A single case
  is still fine as a one-entry table if more will likely follow.
- Keep docs in sync: when a change affects documented behavior (API shape, schema, architecture,
  conventions, env vars), update the relevant doc in the same change, not as a follow-up.
- New env var / config value: add it to the project's example/template env file (`.env.example`
  or equivalent) in the same change, never as a follow-up.
- Flat over nested: prefer guard clauses/early returns over deep if/else nesting. Extract a
  helper when a block starts stacking conditionals instead of adding another level.
