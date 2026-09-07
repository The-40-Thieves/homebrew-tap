# homebrew-tap

Homebrew tap for The 40 Thieves tools.

## Install

```
brew install the-40-thieves/tap/alexandria-mcp
brew install the-40-thieves/tap/obsidian-tc
```

## Formulae

- `alexandria-mcp`: MCP server for natural-language search, full-text reading,
  and cited answers across 152 public research libraries (papers, books, law,
  government records, security advisories, news, and developer docs). Wraps
  the `@the-40-thieves/alexandria-mcp` npm package. Homepage:
  https://github.com/The-40-Thieves/alexandria-mcp
- `obsidian-tc`: model-agnostic, agent-ready MCP server for Obsidian vaults
  with RBAC, SLSA provenance, and native search. Installs the prebuilt Bun
  standalone binary published on each GitHub release (macOS arm64/x64, Linux
  arm64/x64). Homepage: https://github.com/The-40-Thieves/obsidian-tc

## Assets

`assets/alexandria-logo-400.png` is a 400x400 logo used in third-party
directory submissions (for example the Cline MCP Marketplace).

## Status

This tap has not yet been audited on macOS. Homebrew is not installed on the
Linux host that authored this formula, so `brew audit --new --formula
Formula/alexandria-mcp.rb` still needs to run on a Mac before this tap is
considered fully verified. The formula was written against the documented
`std_npm_args` / `libexec` pattern for npm-based formulae and the tarball
sha256 was computed directly from the published npm package.

`obsidian-tc.rb` has the same gap — no `brew` on the authoring host, so
`brew audit`/`brew install --formula`/`brew test` for it still need to run on
a Mac (or a Linux box with Homebrew) before it is fully verified. Its four
`sha256` values were independently computed (`shasum -a 256`) from the
downloaded `v1.28.4` release assets and cross-checked against that release's
`SHASUMS256.txt` and GitHub's own per-asset `digest` field; the linux-arm64
binary was executed directly (`--version` printed `1.28.4`) as evidence the
asset matches what the formula installs. **This formula must be bumped by
hand on every obsidian-tc release** (`version` + four `sha256` values) —
`obsidian-tc`'s `publish.yml` does not yet open a PR here automatically; that
automation is a follow-up, not yet built.

## Automation

`.github/workflows/bump-obsidian-tc.yml` keeps `Formula/obsidian-tc.rb`
current on its own: every 6 hours (and on demand) it checks the latest
non-prerelease, non-draft release of `The-40-Thieves/obsidian-tc`, and if the
formula's `version` is already at that tag it does nothing. Otherwise it
downloads that release's `SHASUMS256.txt` and all four platform binaries,
independently verifies each binary's sha256 against the file before trusting
it, rewrites the formula's `version` and four `sha256` lines
(`scripts/bump-obsidian-tc.sh`), and pushes the commit straight to `main` as
`github-actions[bot]` (this tap has no CI to gate the push on). It runs
tap-side rather than as a push from obsidian-tc's own `publish.yml` because a
same-repo commit only needs this workflow's own `GITHUB_TOKEN`, while a
cross-repo push would need a PAT or GitHub App. It never pushes a tag or cuts
a release here -- only the formula file changes. To run it by hand: **Actions
→ bump obsidian-tc formula → Run workflow**, optionally filling in a specific
`tag` (e.g. `v1.28.5`); leave it blank to bump to the latest release.
