# claude-code-example-orders-workspace

A **workspace package**: work on orders-api and orders-web together in one Claude Code session.
Part of the [claude-code-example-team-setup](https://github.com/rearc/claude-code-example-team-setup)
example, which explains when to use this and when to work in each repo on its own (the default).

This folder is the agent you act as. Its `CLAUDE.md` holds cross-repo guidance and its
`.claude/settings.json` governs the session. Each repo keeps its own CLAUDE.md, rules (path-scoped
ones included), skills, subagents and plugins, and they apply as Claude works in that repo. The
repos' own settings files don't apply here, so anything they enforce that must hold here is restated
in this workspace's settings.

That includes plugins. The workspace turns on, in its own settings, the plugins it wants in this
session (here, the ones both repos use). A repo turning a plugin on isn't enough when Claude
starts here: Claude loads a team-marketplace plugin only if it's installed for the folder it
started in. Listing them here also makes the choice deliberate, and leaves each repo's own setup
alone for when you work in that repo by itself. `setup.sh` warns if a repo turns on a plugin this
workspace doesn't.

| File | Purpose |
|---|---|
| `CLAUDE.md` | How the repos fit together, and the order of work |
| `.claude/skills/change-api-contract/` | The cross-repo procedure |
| `.claude/settings.json` | Governs the session: the repos' deny rules restated, and the plugins this workspace turns on |
| `repos.txt` | The repos and their URLs |
| `setup.sh`, `setup.ps1` | Clone the repos into `repos/`, install the plugins they turn on |
| `start.sh`, `start.ps1` | Start Claude here with each repo added (CLI) |
| `orders.code-workspace` | The same session in VS Code |

## Setup (once)
- Mac/Linux: `./setup.sh`. Windows: `.\setup.ps1`.

## Use
- VS Code: open `orders.code-workspace`. The workspace folder is first, so the Claude Code
  extension starts there and adds the repos. The repos appear twice in the explorer: inside
  `repos/` and as their own folders. Same files; edit either.
- CLI: `./start.sh` (or `.\start.ps1`). Extra arguments pass through to `claude`.

## Adding a repo
Add a line to `repos.txt` and a folder to `orders.code-workspace`, then rerun setup.
