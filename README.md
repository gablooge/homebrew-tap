# gablooge/tap

Homebrew formulae by [gablooge](https://github.com/gablooge).

| Formula | What it is |
|---|---|
| `punk-records` | [Punk Records](https://github.com/gablooge/punk-records): sync your AI agents' memories (CLAUDE.md, AGENTS.md, napkins, rules) across projects and machines, with an MCP server |

```bash
brew install gablooge/tap/punk-records
punk --version
```

macOS and Linux. `brew upgrade punk-records` picks up new releases.

## Maintenance

- `tests` installs, tests and audits the formula on macOS and Linux for every pull request and push.
- `autobump` runs daily and opens a pull request when PyPI has a new punk-records. Those pull
  requests come from GITHUB_TOKEN, which does not start other workflows, so run `tests` on the
  branch (Actions, tests, Run workflow) before merging.
