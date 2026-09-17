# Database Migrations

**Hard gate. Applies to any schema migration, every project.**

- Adding a required (NOT NULL) column to a populated table: add it nullable first, backfill
  existing rows, then add the NOT NULL constraint as a separate step — never all in one migration.
- Adding a migration or a new query: confirm it's backed by an index for its access pattern.
  Add one if it isn't.
