#!/usr/bin/env -S nix shell -L nixpkgs#python3 -c bash
# shellcheck shell=bash
set -euo pipefail

# Run the passthru.updateScript of every (or selected) package — the daily CI entry point.
# Usage: run-update-scripts.sh [attr ...]
#
# Mirrors the nixpkgs maintainers/scripts/update.nix contract: the command comes from
# `updateScript.command or updateScript`, scripts receive UPDATE_NIX_NAME/PNAME/
# OLD_VERSION/ATTR_PATH, and the executor is the update.py of the same pinned nixpkgs.
# Evaluation root is pkgs/: nested nix-update and `nix-build -A` resolve ./default.nix.

REPO_ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 && pwd)
cd "$REPO_ROOT"

NIXPKGS=$(nix eval --raw .#nixpkgs)
export NIX_PATH="nixpkgs=$NIXPKGS"

select='['
for attr in "$@"; do
  select+=" \"$attr\""
done
select+=']'

# Like update.nix's packagesJson, writeText's string context builds every derivation the
# scripts reference (gitUpdater's writeScript, the nix-update binary, ...).
packages_json=$(
  nix-build --no-out-link \
    --arg select "$select" \
    -E '{ select }: with import <nixpkgs> { }; writeText "update-script-packages.json" (builtins.toJSON (import ./_scripts/update-scripts.nix { inherit pkgs; inherit select; }))'
)

# gitUpdater-style scripts write update-git-commits.txt and failure logs into the cwd.
cd "$REPO_ROOT/pkgs"
trap 'rm -f update-git-commits.txt ./*.log' EXIT

python3 "$NIXPKGS/maintainers/scripts/update.py" "$packages_json" --skip-prompt --max-workers 1
