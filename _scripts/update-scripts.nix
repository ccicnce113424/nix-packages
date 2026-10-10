# Generate `packages.json` entries for `maintainers/scripts/update.py`.
#
# The normalization mirrors `packageData` in nixpkgs' `maintainers/scripts/update.nix`:
# `command or self` → `lib.toList` → `toString`, with `attrPath`/`supportedFeatures` passed
# through. Unlike update.nix, evaluation goes through `import ../pkgs { }` (the repo's
# evaluation root is `pkgs/`), so path literals stay real working-tree paths and update
# scripts can write sidecar files next to themselves.
{
  pkgs ? import <nixpkgs> { },
  # Restrict to these attribute names; empty list means all.
  select ? [ ],
}:
let
  inherit (pkgs) lib;
  scope = import ../pkgs { inherit pkgs; };

  dataOf =
    name:
    let
      evaluated = builtins.tryEval scope.${name};
      pkg = if evaluated.success then evaluated.value else null;
      us = if pkg != null && lib.isDerivation pkg then (pkg.updateScript or null) else null;
    in
    if us == null then
      null
    else
      {
        inherit name;
        pname = lib.getName pkg;
        oldVersion = lib.getVersion pkg;
        updateScript = map toString (lib.toList (us.command or us));
        supportedFeatures = us.supportedFeatures or [ ];
        attrPath = us.attrPath or name;
      };

  # Run a script shared by multiple attributes (e.g. open-orpheus and open-orpheus-dev)
  # only once. The key includes attrPath because bare `nix-update` commands are textually
  # identical across packages and are told apart by UPDATE_NIX_ATTR_PATH; a genuinely
  # shared script opts in by pinning the same `attrPath` on each declaration.
  dedup =
    entries:
    lib.foldl' (
      acc: e:
      if lib.any (x: x.updateScript == e.updateScript && x.attrPath == e.attrPath) acc then
        acc
      else
        acc ++ [ e ]
    ) [ ] entries;

  entries = lib.filter (e: e != null && (select == [ ] || lib.elem e.name select)) (
    map dataOf (builtins.attrNames scope)
  );
in
dedup entries
