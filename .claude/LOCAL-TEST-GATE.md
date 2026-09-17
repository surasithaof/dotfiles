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
