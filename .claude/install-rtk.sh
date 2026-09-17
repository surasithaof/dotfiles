#!/usr/bin/env bash
# Installs the rtk CLI (https://github.com/rtk-ai/rtk), used by the Bash PreToolUse hook
# in the synced settings.json. Not a Claude Code plugin, so it's separate from install-plugins.sh.
set -euo pipefail

if command -v rtk >/dev/null 2>&1; then
  echo "rtk already installed: $(rtk --version)"
  exit 0
fi

curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
