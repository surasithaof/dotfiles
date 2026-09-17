# Testing

- When adding or changing a public interface (endpoint, exported function, CLI command), include
  tests covering: success path, validation/input errors, and dependency-failure paths (DB/network/etc).
- If the project has a separate e2e/integration suite, add coverage there too, following the
  existing structure (one file per case/status, registered wherever the suite indexes them).
- If the OpenAPI/schema or other generated-types source changes, regenerate derived client types
  in the same change.
- Bug fixes: where practical, write a test that reproduces the bug and watch it fail, before
  writing the fix.
