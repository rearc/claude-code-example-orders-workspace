#!/bin/bash
# Start Claude Code in this workspace with every repo in repos.txt added
# (the same session VS Code starts from team.code-workspace). Extra arguments pass through.
cd "$(dirname "$0")"
args=()
while read -r name url; do [ -n "${name:-}" ] && args+=(--add-dir "repos/$name"); done < repos.txt
exec claude "${args[@]}" "$@"
