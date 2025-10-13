# Zed configs

- Settings for Zed editor. See more [here](https://zed.dev/docs/configuring-zed).
- Theme edite from [here](https://zed-themes.com/themes/edit/).

# Direnv configs

- Zed integrates with [direnv](https://direnv.net/) to manage environment variables per project [See](https://zed.dev/docs/configuring-zed#direnv-integration).
- To enable direnv integration, ensure you have direnv installed and configured in your shell.

2 options to load environment variables from a `.env` file using direnv:

- Copy [direnv.toml](./direnv/direnv.toml) to `~/.config/direnv/direnv.toml` (if this file is not exists then create it), And restart Zed. It's already set load_dotenv to true globally.
- Add a `.envrc` file in your project root, and add `dotenv .env` or `dotenv_if_exists .env` to it. Example:

  ```bash
  # .envrc
  dotenv .env
  ```

  After creating or modifying `.envrc`, run `direnv allow` in the terminal to apply the changes.
