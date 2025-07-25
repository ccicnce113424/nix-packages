# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchurl,
  fetchFromGitHub,
}:
{
  algermusicplayer-arm = {
    pname = "algermusicplayer-arm";
    version = "4.8.2";
    src = fetchurl {
      url = "https://github.com/algerkong/AlgerMusicPlayer/releases/download/v4.8.2/AlgerMusicPlayer-4.8.2-linux-arm64.AppImage";
      sha256 = "sha256-V+pCKDC1cCD7wxuQ9wRYFVfVg2Ltevawkgo6dk9jIDE=";
    };
  };
  algermusicplayer-x86 = {
    pname = "algermusicplayer-x86";
    version = "4.8.2";
    src = fetchurl {
      url = "https://github.com/algerkong/AlgerMusicPlayer/releases/download/v4.8.2/AlgerMusicPlayer-4.8.2-linux-x86_64.AppImage";
      sha256 = "sha256-T0G/jc3foW3a/opUKybU4HkGKqPEkxNy8JppC8bwyR4=";
    };
  };
  danmakufactory = {
    pname = "danmakufactory";
    version = "v1.70";
    src = fetchFromGitHub {
      owner = "hihkm";
      repo = "DanmakuFactory";
      rev = "v1.70";
      fetchSubmodules = false;
      sha256 = "sha256-dPgWVJuNOzTc+ocMyGHBb4ExB9P1Wu+uTQ62UejAAfE=";
    };
  };
  danmakufactory-git = {
    pname = "danmakufactory-git";
    version = "647c7e6d5bc7c57c215846c0be9ccbc54c7f8ad4";
    src = fetchFromGitHub {
      owner = "hihkm";
      repo = "DanmakuFactory";
      rev = "647c7e6d5bc7c57c215846c0be9ccbc54c7f8ad4";
      fetchSubmodules = true;
      sha256 = "sha256-xm+kYLIlC5pTRgbxyX4IU4jBmj1Ip33S6VN3W5JxSs0=";
    };
    date = "2025-07-25";
  };
  lxgw-wenkai-gb = {
    pname = "lxgw-wenkai-gb";
    version = "v1.520";
    src = fetchTarball {
      url = "https://github.com/lxgw/LxgwWenkaiGB/releases/download/v1.520/lxgw-wenkai-gb-v1.520.tar.gz";
      sha256 = "sha256-6dZDzz0PPG18x4DzUH/qzq+1grbNIDP6ZDJA4uAOwxc=";
    };
  };
  mpv-handler = {
    pname = "mpv-handler";
    version = "v0.3.16";
    src = fetchFromGitHub {
      owner = "akiirui";
      repo = "mpv-handler";
      rev = "v0.3.16";
      fetchSubmodules = false;
      sha256 = "sha256-RpfHUVZmhtneeu8PIfxinYG3/groJPA9QveDSvzU6Zo=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./mpv-handler-v0.3.16/Cargo.lock;
      outputHashes = {

      };
    };
  };
  pixes = {
    pname = "pixes";
    version = "v1.1.1";
    src = fetchFromGitHub {
      owner = "wgh136";
      repo = "pixes";
      rev = "v1.1.1";
      fetchSubmodules = false;
      sha256 = "sha256-kmbinF4jCelqDkjxAKxnaO+GrIdX9GBHKqaykpPsCGo=";
    };
    "pubspec.lock" = builtins.readFile ./pixes-v1.1.1/pubspec.lock;
  };
  pixes-git = {
    pname = "pixes-git";
    version = "72eb4a51eada9fdd5613de9d55b13d2fcac4bbcc";
    src = fetchFromGitHub {
      owner = "wgh136";
      repo = "pixes";
      rev = "72eb4a51eada9fdd5613de9d55b13d2fcac4bbcc";
      fetchSubmodules = false;
      sha256 = "sha256-MOdaYS02qoDSc86ZgyYtGNJ2BlcEaPEFCoyC0GQr6lo=";
    };
    "pubspec.lock" =
      builtins.readFile ./pixes-git-72eb4a51eada9fdd5613de9d55b13d2fcac4bbcc/pubspec.lock;
    date = "2025-06-28";
  };
  splayer-git = {
    pname = "splayer-git";
    version = "bfcd59dacab07fd665e71a311c5fe8c0a3c548a7";
    src = fetchFromGitHub {
      owner = "imsyy";
      repo = "SPlayer";
      rev = "bfcd59dacab07fd665e71a311c5fe8c0a3c548a7";
      fetchSubmodules = false;
      sha256 = "sha256-SpaisGy7Tcaurgyt4kFYifhIeWoAQoufHZ+8zZaFAvk=";
    };
    date = "2025-05-23";
  };
  uosc-danmaku = {
    pname = "uosc-danmaku";
    version = "v1.3.2";
    src = fetchFromGitHub {
      owner = "Tony15246";
      repo = "uosc_danmaku";
      rev = "v1.3.2";
      fetchSubmodules = false;
      sha256 = "sha256-aeqzdL9i5SkfeW3kXSzubw4vfb7clQhV9DQqANFuAnk=";
    };
  };
  uosc-danmaku-git = {
    pname = "uosc-danmaku-git";
    version = "ab58b083e99727fdbe037a7919f03773c4b29731";
    src = fetchFromGitHub {
      owner = "Tony15246";
      repo = "uosc_danmaku";
      rev = "ab58b083e99727fdbe037a7919f03773c4b29731";
      fetchSubmodules = false;
      sha256 = "sha256-oGscePqaGyG8zJYZxMxHmJc3PEwsRsl0G9Q5RghikJA=";
    };
    date = "2025-07-26";
  };
  vulkan-hdr-layer-kwin6 = {
    pname = "vulkan-hdr-layer-kwin6";
    version = "1384036ea24a9bc38a5c684dac5122d5e3431ae6";
    src = fetchFromGitHub {
      owner = "Zamundaaa";
      repo = "VK_hdr_layer";
      rev = "1384036ea24a9bc38a5c684dac5122d5e3431ae6";
      fetchSubmodules = true;
      sha256 = "sha256-xm0S1vLE8MAov8gf6rN5ZKZAe6NMKfHDlUlmNd332qw=";
    };
    date = "2025-05-22";
  };
  zhuque = {
    pname = "zhuque";
    version = "v0.212";
    src = fetchurl {
      url = "https://github.com/TrionesType/zhuque/releases/download/v0.212/ZhuqueFangsong-v0.212.zip";
      sha256 = "sha256-u4tmGnZD0ilqctnRBTCgCUlBnE5Sf7YXg/c8K6GowGI=";
    };
  };
}
