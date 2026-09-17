# Master Releasable

**Hard gate. Applies in every project, every session.**

The default branch stays in a shippable state at all times. Work that isn't ready to ship yet
goes behind a feature flag/toggle — never merged half-built and left incomplete on the branch.

- Before merging, ask: if this branch deployed right now, would it break anything? If yes, gate
  it behind a flag or hold the merge.
- A flag defaults off until the feature is complete, then gets flipped on and removed once it's
  no longer needed — it's not permanent scaffolding.
