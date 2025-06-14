{
  pkgs ? import <nixpkgs> { },
}:
(import ../.).overlays.default pkgs pkgs
