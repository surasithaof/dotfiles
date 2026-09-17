# Phase Breaking Changes

**Hard gate. Applies to any change that could break a consumer (API, behavior, DB, config).**

Never ship the add and the removal in the same release. Split into two:

1. This release: add the new behavior alongside the old, mark the old as deprecated.
2. A later release: remove the deprecated old behavior, once consumers have migrated.

No exception for "the change is small" — size doesn't change how a consumer experiences a break.
