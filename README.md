# homebrew-tap

Homebrew tap for The 40 Thieves tools.

## Install

```
brew install the-40-thieves/tap/alexandria-mcp
```

## Formulae

- `alexandria-mcp`: MCP server for natural-language search, full-text reading,
  and cited answers across 152 public research libraries (papers, books, law,
  government records, security advisories, news, and developer docs). Wraps
  the `@the-40-thieves/alexandria-mcp` npm package. Homepage:
  https://github.com/The-40-Thieves/alexandria-mcp

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
