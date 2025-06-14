# First, we use flake-compat in `../default.nix` if `getFlake` is not available.
# Then, we use `toString` to convert a relative path into a string that contains an absolute path, so that `getFlake` is happy with it.
# We also treat the overlay as a regular Nix function so that the provided nixpkgs is always being used.
{
  pkgs ? import <nixpkgs> { },
}:
(builtins.getFlake or import (builtins.toString ../.)).overlays.default pkgs pkgs
