#!/usr/bin/env bash
# Rewrites Formula/obsidian-tc.rb's `version` line and its four platform
# `sha256` lines to match a new obsidian-tc release.
#
# Usage:
#   bump-obsidian-tc.sh <tag> <shasums-file> <formula-file>
#
#   <tag>           release tag, e.g. v1.28.5 (the leading "v" is stripped
#                   to produce the formula's `version` string)
#   <shasums-file>  a SHASUMS256.txt as published on the release, already
#                   verified by the caller against the actual downloaded
#                   binaries -- this script trusts the digests it is given,
#                   it does not itself check them against any binary
#   <formula-file>  path to Formula/obsidian-tc.rb (edited in place)
#
# Idempotent: running it again with the same tag and shasums against a
# formula that already carries that version/digests produces no diff.
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "usage: $0 <tag> <shasums-file> <formula-file>" >&2
  exit 2
fi

tag=$1
shasums_file=$2
formula_file=$3

version=${tag#v}

for f in "$shasums_file" "$formula_file"; do
  if [[ ! -f $f ]]; then
    echo "$0: no such file: $f" >&2
    exit 1
  fi
done

# The four prebuilt-binary assets the formula pins, in the order their
# on_macos/on_linux/on_arm/on_intel blocks appear in the formula.
platform_suffixes=(darwin-arm64 darwin-x64 linux-arm64 linux-x64)

sha_for_suffix() {
  local suffix=$1 line
  # SHASUMS256.txt lines look like "<sha>  ./binary-.../obsidian-tc-bun-<suffix>";
  # anchor on the filename suffix so a path prefix doesn't matter.
  line=$(grep -E "obsidian-tc-bun-${suffix}\$" "$shasums_file" || true)
  if [[ -z $line ]]; then
    echo "$0: no digest for obsidian-tc-bun-${suffix} in ${shasums_file}" >&2
    exit 1
  fi
  awk '{ print $1 }' <<<"$line"
}

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
cp "$formula_file" "$tmp"

sed -i -E "s/^(  version \")[^\"]*(\")\$/\\1${version}\\2/" "$tmp"

for suffix in "${platform_suffixes[@]}"; do
  sha=$(sha_for_suffix "$suffix")
  # Rewrite only the sha256 line immediately following the url line that
  # names this platform's asset, so each digest lands in its own block.
  awk -v needle="obsidian-tc-bun-${suffix}" -v sha="$sha" '
    $0 ~ needle { target = NR + 1 }
    NR == target { sub(/sha256 "[^"]*"/, "sha256 \"" sha "\"") }
    { print }
  ' "$tmp" >"${tmp}.next"
  mv "${tmp}.next" "$tmp"
done

mv "$tmp" "$formula_file"
trap - EXIT
