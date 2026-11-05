#!/bin/bash
# One-time setup: clone the repos in repos.txt into repos/ and install every plugin that this
# workspace or the repos turn on (at project scope, as their committed settings expect).
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p repos
while read -r name url; do
  [ -z "${name:-}" ] && continue
  [ -d "repos/$name" ] || git clone -q "$url" "repos/$name"
  echo "repo:   $name"
done < repos.txt
python3 - <<'PY'
import json, pathlib, subprocess
for d in [pathlib.Path(".")] + sorted(p for p in pathlib.Path("repos").iterdir() if p.is_dir()):
    s = d / ".claude" / "settings.json"
    if not s.exists():
        continue
    cfg = json.loads(s.read_text())
    for name, m in cfg.get("extraKnownMarketplaces", {}).items():
        src = m["source"]
        arg = src.get("path") or src.get("url") or src.get("repo")
        r = subprocess.run(["claude", "plugin", "marketplace", "add", arg, "--scope", "project"], cwd=d, capture_output=True, text=True)
        print(f"market: {name} for {d}: {'ok' if r.returncode == 0 else r.stderr.strip()[:200]}")
    for pid, on in cfg.get("enabledPlugins", {}).items():
        if on:
            r = subprocess.run(["claude", "plugin", "install", pid, "--scope", "project"], cwd=d, capture_output=True, text=True)
            print(f"plugin: {pid} for {d}: {'installed' if r.returncode == 0 else r.stderr.strip()[:200]}")
PY
echo "Done. VS Code: open orders.code-workspace. CLI: ./start.sh"
