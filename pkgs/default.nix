{
  pkgs ? import <nixpkgs>,
}:
let
  sources = pkgs.callPackage ../_sources/generated.nix { };
in
rec {
  shijima-qt = pkgs.callPackage ./shijima-qt { };
  danmakufactory = pkgs.callPackage ./danmakufactory { inherit sources; };
  uosc-danmaku = pkgs.mpvScripts.callPackage ./uosc-danmaku { inherit sources danmakufactory; };
  wpsoffice-365 = pkgs.libsForQt5.callPackage ./wpsoffice-365 { };
  mpv-handler = pkgs.callPackage ./mpv-handler { inherit sources; };
}
