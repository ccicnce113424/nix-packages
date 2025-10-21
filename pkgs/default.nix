{
  pkgs ? import <nixpkgs> { },
}:
let
  inherit (pkgs) lib;
  fetchedSrc = pkgs.callPackage ../_sources/generated.nix { };
  stableVersion = src: lib.removePrefix "v" src.version;
  unstableVersion = src: "0-unstable-${src.date}";
in
rec {
  algermusicplayer = pkgs.callPackage ./algermusicplayer { inherit fetchedSrc; };

  danmakufactory = pkgs.callPackage ./danmakufactory rec {
    sources = fetchedSrc.danmakufactory;
    version = stableVersion sources;
  };
  danmakufactory-git =
    (pkgs.callPackage ./danmakufactory-git rec {
      sources = fetchedSrc.danmakufactory-git;
      version = unstableVersion sources;
    }).overrideAttrs
      {
        meta.broken = true;
      };

  lxgw-wenkai-gb = pkgs.callPackage ./lxgw-wenkai-gb rec {
    sources = fetchedSrc.lxgw-wenkai-gb;
    version = stableVersion sources;
  };

  mpv-handler = pkgs.callPackage ./mpv-handler rec {
    sources = fetchedSrc.mpv-handler;
    version = stableVersion sources;
  };

  piliplus = pkgs.callPackage ./piliplus rec {
    sources = fetchedSrc.piliplus;
    inherit (sources) version;
    pubspecLock = builtins.fromJSON (builtins.readFile ./piliplus/pubspec.lock.json);
    gitHashes = import ./piliplus/git-hashes.nix;
  };

  pixes = pkgs.callPackage ./pixes rec {
    sources = fetchedSrc.pixes;
    version = stableVersion sources;
    pubspecLock = builtins.fromJSON (builtins.readFile ./pixes/pubspec.lock.json);
    gitHashes = import ./pixes/git-hashes.nix;
  };
  pixes-git = pkgs.callPackage ./pixes rec {
    sources = fetchedSrc.pixes-git;
    version = unstableVersion sources;
    pubspecLock = builtins.fromJSON (builtins.readFile ./pixes/git/pubspec.lock.json);
    gitHashes = import ./pixes/git/git-hashes.nix;
  };

  shijima-qt = pkgs.callPackage ./shijima-qt { };

  inherit (pkgs) splayer;

  splayer-git = pkgs.callPackage ./splayer-git rec {
    hash = import ./splayer-git/hash-git.nix;
    sources = fetchedSrc.splayer-git;
    version = unstableVersion sources;
    inherit splayer;
  };

  uosc-danmaku = pkgs.mpvScripts.callPackage ./uosc-danmaku rec {
    sources = fetchedSrc.uosc-danmaku;
    version = stableVersion sources;
  };
  uosc-danmaku-git = pkgs.mpvScripts.callPackage ./uosc-danmaku rec {
    sources = fetchedSrc.uosc-danmaku-git;
    version = unstableVersion sources;
  };

  # wpsoffice-365 = pkgs.libsForQt5.callPackage ./wpsoffice-365 { };

  vulkan-hdr-layer-kwin6 =
    if (builtins.tryEval pkgs.vulkan-hdr-layer-kwin6).success then
      pkgs.vulkan-hdr-layer-kwin6
    else
      pkgs.callPackage ./vulkan-hdr-layer-kwin6 rec {
        sources = fetchedSrc.vulkan-hdr-layer-kwin6;
        version = unstableVersion sources;
      };

  zhuque = pkgs.callPackage ./zhuque rec {
    sources = fetchedSrc.zhuque;
    version = stableVersion sources;
  };
}
