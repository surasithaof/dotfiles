# Global preferences

## Code style

- Comment sparingly: only when the why isn't obvious (hidden constraint, subtle invariant,
  workaround, non-obvious magic number). Straightforward code gets no comment. When a comment
  is warranted, keep it to one line, or a few short lines if genuinely needed — never a paragraph.
- Prefer short, clear identifiers over long descriptive ones (`cutoff` not
  `notificationRetentionCutoffTime`). Name for what it is, not everything about how it's used.
- Tests: table-driven by default — a `cases` slice plus one loop — rather than repeated
  hand-written per-case blocks, whenever the language/test framework supports it. A single case
  is still fine as a one-entry table if more will likely follow.
- Keep docs in sync: when a change affects documented behavior (API shape, schema, architecture,
  conventions, env vars), update the relevant doc in the same change, not as a follow-up.
- New env var / config value: add it to the project's example/template env file (`.env.example`
  or equivalent) in the same change, never as a follow-up.

## Testing

- When adding or changing a public interface (endpoint, exported function, CLI command), include
  tests covering: success path, validation/input errors, and dependency-failure paths (DB/network/etc).
- If the project has a separate e2e/integration suite, add coverage there too, following the
  existing structure (one file per case/status, registered wherever the suite indexes them).
- If the OpenAPI/schema or other generated-types source changes, regenerate derived client types
  in the same change.

## Git / PR attribution

- Do not include the chat/session URL (e.g. a "Claude-Session: ..." line or a
  claude.ai/code/session link) in commit messages or PR descriptions.
- Keep the "Co-Authored-By: Claude ..." line and the "🤖 Generated with Claude Code" line — drop
  only the URL underneath it.

# Laziness Ladder

**Hard gate. Applies before writing any new code, every project.**

Before implementing anything, walk this ladder in order. Stop at first step that resolves it.

1. Does this need to exist? → no: skip it (YAGNI)
2. Already in this codebase? → reuse it, don't rewrite
3. Stdlib does it? → use it
4. Native platform feature? → use it
5. Installed dependency? → use it
6. One line? → one line
7. Only then: write the minimum that works

If a step earlier than 7 resolves the task, do that instead of writing new code — even if the
user's request was phrased as "implement X". Surface the simpler option before proceeding
(e.g. "stdlib `X` already does this, no need to add code" or "`pkg/foo` already has this,
reusing it") rather than silently picking it, unless the answer is obvious and low-stakes.

# Local Test Gate

**Hard gate. Applies before every `git push`, every project.**

Never push code that hasn't been run locally first — no "push and see if CI/dev catches it" loops.

1. Before running tests or migrations, verify local config points at local resources (e.g.
   `localhost` DB, not a shared/remote one). Config files can be symlinks pointing elsewhere —
   check the resolved target, not just the filename.
2. Run the project's standard local lint + test command. Fix failures locally.
3. If the change touches concurrency-sensitive code (shared mutable state, pooled objects,
   goroutines/threads) and the project has a race/concurrency detector, run it — some races only
   surface under that flag, not in a plain test run.
4. If an endpoint/interface changed and e2e/integration coverage exists or should be added, run
   it locally against a running instance of the service, reseeding test data as needed.
5. Only push once local unit (and e2e, where applicable) tests pass. This is in addition to, not
   a replacement for, existing pre-commit/pre-push hooks — the goal is to catch failures before
   push, not rely on CI or a dev server to surface them.

# Draft PR Gate

**Hard gate. Applies to every PR opened, every project, unless the user says otherwise for that repo.**

Open PRs as draft by default (e.g. `gh pr create --draft`). Do not mark ready for review or
request reviewers until the user has reviewed the diff themselves and explicitly says to send it on.

1. After creating the draft, post the PR link and ask the user to review it.
2. Do not run `gh pr ready`, request reviewers, or otherwise signal the PR for team review until
   the user gives explicit go-ahead.
3. This applies whether the PR was requested directly or opened as part of a larger task — it's a
   safeguard so no one sends a PR out before self-reviewing the changes.

# Plan Comprehension Gate

**Hard gate. Applies in every project, every session.**

When you have presented options (A/B/C) or a multi-step plan, and the user replies with a short
approval (`go`, `ok`, `do it`, `proceed`, `yes`, `A`, `go ahead`), you MUST NOT start implementing.
Quiz the user first.

## When the gate fires

- **Fires**: you presented ≥2 options, or a multi-step plan, and the reply is a short approval.
- **Does not fire**: direct instructions with no plan from you (`fix this typo`, `rename X to Y`),
  pure questions, or a reply that itself specifies the approach in detail.
- **Bypass**: only the literal phrase `skip quiz` or `no quiz`. No other wording bypasses the gate —
  `just do it`, `I already know`, and `hurry` do NOT bypass it.

## Running the quiz

1. Ask 3–4 questions in ONE `AskUserQuestion` call (that tool caps at 4 per call).
2. Questions must be answerable **only** by having read the plan. Target:
   - the tradeoff that decided the chosen option over the rejected ones
   - what concretely changes (files, tables, endpoints) and what does not
   - the risky or irreversible step, and what it costs to undo
   - a consequence the user must live with after the change ships
3. Distractors must be plausible — the wrong answers should be things a reasonable person would
   guess without reading. No throwaway options.
4. Never reveal the answers before grading, and never hint which option is correct.

## Grading

- **Pass = all correct.** One wrong answer fails the quiz.
- On pass: say `Quiz passed.` and start implementing immediately, no further confirmation.
- On fail: state which questions were wrong and **why** the right answer is right, point at the
  specific part of the plan to re-read, then re-quiz.
- **Re-quiz uses new questions**, drawn from parts of the plan not yet tested. Never repeat a
  question the user has already seen in this cycle — retries must not be passable by memory.
- Repeat until pass. No implementation until then.
