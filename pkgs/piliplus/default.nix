{
  sources,
  version,
  lib,
  flutter329,
  makeDesktopItem,
  autoPatchelfHook,
  copyDesktopItems,
  git,
  mpv,
  alsa-lib,
  libass,
  ffmpeg,
  libplacebo,
  libunwind,
  shaderc,
  vulkan-loader,
  lcms,
  libdovi,
  libdvdnav,
  libdvdread,
  mujs,
  libbluray,
  lua,
  rubberband,
  libuchardet,
  zimg,
  openal,
  pipewire,
  libpulseaudio,
  libcaca,
  libdrm,
  libdisplay-info,
  libgbm,
  libXScrnSaver,
  libXpresent,
  nv-codec-headers-12,
  libva,
  libvdpau,
}:

flutter329.buildFlutterApplication rec {
  inherit (sources) pname src;
  inherit version;

  pubspecLock = lib.importJSON ./pubspec.lock.json;

  desktopItems = [
    (makeDesktopItem {
      name = "piliplus";
      exec = "piliplus";
      icon = "piliplus";
      genericName = "PiliPlus";
      desktopName = "PiliPlus";
      categories = [
        "AudioVideo"
        "Video"
        "Network"
      ];
    })
  ];

  nativeBuildInputs = [
    autoPatchelfHook
    copyDesktopItems
    git
  ];

  buildInputs = [
    mpv
    alsa-lib
    libass
    ffmpeg
    libplacebo
    libunwind
    shaderc
    vulkan-loader
    lcms
    libdovi
    libdvdnav
    libdvdread
    mujs
    libbluray
    lua
    rubberband
    libuchardet
    zimg
    openal
    pipewire
    libpulseaudio
    libcaca
    libdrm
    libdisplay-info
    libgbm
    libXScrnSaver
    libXpresent
    nv-codec-headers-12
    libva
    libvdpau
  ];

  gitHashes = import ./git-hashes.nix;

  postPatch = ''
    cat <<EOL > lib/build_config.dart
    class BuildConfig {
      static const int buildTime = 0;
      static const String commitHash = '${src.rev}';
    }
    EOL
  '';

  postInstall = ''
    install -D assets/images/logo/logo.png $out/share/pixmaps/piliplus.png
  '';

  meta = {
    description = "Third-party BiliBili client developed with Flutter";
    homepage = "https://github.com/bggRGjQaUbCoE/PiliPlus";
    changelog = meta.homepage + "/releases";
    mainProgram = "piliplus";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ ccicnce113424 ];
    platforms = lib.platforms.linux;
  };
}
