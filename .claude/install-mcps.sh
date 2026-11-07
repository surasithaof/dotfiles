#!/usr/bin/env bash
# Adds user-scope MCP servers for a fresh machine. Plugin servers come from install-plugins.sh,
# and claude.ai connectors come with the account. Run after the vault syncs, with the Obsidian
# Local REST API plugin enabled. Reads the key at install time: this repo is public.
set -euo pipefail

vault="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault"

if ! claude mcp get notion >/dev/null 2>&1; then
  claude mcp add --transport http --scope user notion https://mcp.notion.com/mcp
fi

if ! claude mcp get obsidian >/dev/null 2>&1; then
  key=$(jq -er .apiKey "$vault/.obsidian/plugins/obsidian-local-rest-api/data.json")
  claude mcp add --transport http --scope user obsidian http://127.0.0.1:27123/mcp/ \
    --header "Authorization: Bearer $key"
fi

echo "Run /mcp in Claude Code to log in to notion. Obsidian must be open to connect."
