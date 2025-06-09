{
  pkgs ? import <nixpkgs>,
}:
rec {
  shijima-qt = pkgs.callPackage ./shijima-qt { };
  danmakufactory = pkgs.callPackage ./danmakufactory { };
  uosc-danmaku = pkgs.mpvScripts.callPackage ./uosc-danmaku { inherit danmakufactory; };
  wpsoffice-365 = pkgs.libsForQt5.callPackage ./wpsoffice-365 { };
  mpv-handler = pkgs.callPackage ./mpv-handler { };
}
