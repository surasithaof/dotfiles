# dotfiles

This repository will keep configurations of mine for ease of setup if I format or setup new Mac

- [Zed](/.config/zed) contains theme and settings of Zed editor.
- [VSCode](./vscode/) contains my setting file for Visual Studio Code. this set font family to [JetBrains Mono](https://www.jetbrains.com/lp/mono/).
- [.bunfig.toml](/.bunfig.toml) → copy to `~/.bunfig.toml`. Fixes `UNABLE_TO_GET_ISSUER_CERT_LOCALLY` on `bun install`/`bun outdated` by pointing bun at macOS's live system CA bundle instead of its own (can lag behind CA rotations).
