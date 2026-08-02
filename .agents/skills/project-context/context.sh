#!/usr/bin/env bash
# Live snapshot of this NixOS config repo's current state.
# Agent-agnostic: run directly (`./context.sh`) from any tool/shell, no
# harness-specific skill mechanism required.
#
# Design rule: every section here is either read directly from a file, or
# derived from a pattern stable enough that a mismatch fails *silently empty*
# rather than *silently wrong*. Anything that could plausibly claim a feature
# is enabled/disabled when it isn't (e.g. grepping for "enable = true", which
# misses mkDefault/mkIf and can't see evaluated results) is deliberately left
# out — for authoritative enabled/disabled state, run `nix eval` or
# `nix flake check --no-build` as AGENTS.md recommends. Prefer no answer over
# a wrong one.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

echo "## Flake inputs"
grep -E 'url = |follows' flake.nix || true
echo

echo "## Flake lock revisions"
nix flake metadata --json 2>/dev/null | \
  jq -r '.locks.nodes | to_entries[] | select(.value.locked.rev) | "\(.key): \(.value.locked.rev[0:12]) (\(.value.locked.lastModified | strftime("%Y-%m-%d")))"' \
  2>/dev/null || echo "(nix or jq unavailable — run: nix flake metadata)"
echo

echo "## Hosts and their imported modules"
for host_dir in hosts/*/; do
  host=$(basename "$host_dir")
  echo "-- $host --"
  grep -oE '\.\./?\.?\./?modules/[a-zA-Z0-9_/.-]+\.nix' "$host_dir/default.nix" 2>/dev/null || true
done
echo

echo "## home-manager profiles and their imported modules"
for home_dir in home/*/; do
  user=$(basename "$home_dir")
  echo "-- $user --"
  grep -oE '\./[a-zA-Z0-9_/.-]+\.nix' "$home_dir/default.nix" 2>/dev/null || true
done
echo

echo "## Programs enabled via home-manager (programs.*.enable = true)"
echo "   -- used below to probe installed versions; not authoritative for"
echo "      NixOS system services, only this literal home-manager pattern"
grep -rhoE 'programs\.[a-zA-Z0-9_-]+\.enable = true' home/ 2>/dev/null | \
  sed -E 's/programs\.([a-zA-Z0-9_-]+)\.enable.*/\1/' | sort -u || true
echo

echo "## Versions of tools referenced above (only where the binary matches"
echo "   the option name and is actually on PATH — silently skipped otherwise)"
grep -rhoE 'programs\.[a-zA-Z0-9_-]+\.enable = true' home/ 2>/dev/null | \
  sed -E 's/programs\.([a-zA-Z0-9_-]+)\.enable.*/\1/' | sort -u | \
  while read -r prog; do
    if command -v "$prog" >/dev/null 2>&1; then
      printf '%-12s ' "$prog"
      "$prog" --version 2>/dev/null | head -1 || echo "(--version failed)"
    fi
  done
echo

echo "## Recent commits"
git log --oneline -10
echo

echo "## Working tree status"
git status --short || true
echo

echo "## For authoritative enabled/disabled state (not covered above):"
echo "   nix eval .#nixosConfigurations.<host>.config.<option>"
echo "   nix flake check --no-build"
