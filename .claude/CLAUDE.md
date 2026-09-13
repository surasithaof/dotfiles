# Global preferences

## Code style

- Comment sparingly: only when the why isn't obvious (hidden constraint, subtle invariant,
  workaround, non-obvious magic number). Straightforward code gets no comment. When a comment
  is warranted, keep it to one plain line — never a paragraph.
- Prefer short, clear identifiers over long descriptive ones (`cutoff` not
  `notificationRetentionCutoffTime`). Name for what it is, not everything about how it's used.
- Tests: table-driven by default — a `cases` slice plus one loop — rather than repeated
  hand-written per-case blocks, whenever the language/test framework supports it. A single case
  is still fine as a one-entry table if more will likely follow.
- Keep docs in sync: when a change affects documented behavior (API shape, schema, architecture,
  conventions, env vars), update the relevant doc in the same change, not as a follow-up.

## Git / PR attribution

- Do not include the chat/session URL (e.g. a "Claude-Session: ..." line or a
  claude.ai/code/session link) in commit messages or PR descriptions.
- Keep the "Co-Authored-By: Claude ..." line and the "🤖 Generated with Claude Code" line — drop
  only the URL underneath it.

# Plan Comprehension Gate

**Hard gate. Applies in every project, every session.**

> Mirrored in `acc-hr-service/CLAUDE.md` so that repo's teammates inherit it. Edit both together.

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
