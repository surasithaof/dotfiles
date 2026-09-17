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
