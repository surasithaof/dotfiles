#!/usr/bin/env bash
# Installs the Claude Code marketplaces/plugins this setup depends on, for a fresh machine.
# ascendbit is skipped: its marketplace source is a local directory path specific to one machine
# (/Users/surasith.kae/abc/knowledgebase) and can't be reproduced by this script.
set -euo pipefail

marketplaces=(
  "JuliusBrussee/caveman"
  "forrestchang/andrej-karpathy-skills"
  "DietrichGebert/ponytail"
  "ayghri/i-have-adhd"
)

plugins=(
  "gopls-lsp@claude-plugins-official"
  "frontend-design@claude-plugins-official"
  "context7@claude-plugins-official"
  "code-review@claude-plugins-official"
  "github@claude-plugins-official"
  "feature-dev@claude-plugins-official"
  "playwright@claude-plugins-official"
  "figma@claude-plugins-official"
  "claude-md-management@claude-plugins-official"
  "vercel@claude-plugins-official"
  "swift-lsp@claude-plugins-official"
  "caveman@caveman"
  "andrej-karpathy-skills@karpathy-skills"
  "ponytail@ponytail"
  "i-have-adhd@i-have-adhd"
)

for repo in "${marketplaces[@]}"; do
  claude plugin marketplace add "$repo"
done

for plugin in "${plugins[@]}"; do
  claude plugin install "$plugin" -y
done
