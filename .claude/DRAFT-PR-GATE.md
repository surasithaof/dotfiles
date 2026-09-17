# Draft PR Gate

**Hard gate. Applies to every PR opened, every project, unless the user says otherwise for that repo.**

Open PRs as draft by default (e.g. `gh pr create --draft`). Do not mark ready for review or
request reviewers until the user has reviewed the diff themselves and explicitly says to send it on.

1. After creating the draft, post the PR link and ask the user to review it.
2. Do not run `gh pr ready`, request reviewers, or otherwise signal the PR for team review until
   the user gives explicit go-ahead.
3. This applies whether the PR was requested directly or opened as part of a larger task — it's a
   safeguard so no one sends a PR out before self-reviewing the changes.
