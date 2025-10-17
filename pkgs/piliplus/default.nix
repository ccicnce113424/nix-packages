{
  sources,
  version,
  pubspecLock,
  gitHashes,
  lib,
  flutter335,
  autoPatchelfHook,
  makeDesktopItem,
  copyDesktopItems,
  mpv,
  alsa-lib,
  libass,
  ffmpeg,
  libplacebo,
  libunwind,
  shaderc,
  vulkan-loader,
  lcms2,
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
  xorg,
  nv-codec-headers-12,
  libva,
  libvdpau,
  libayatana-appindicator,
}:

flutter335.buildFlutterApplication rec {
  inherit (sources) pname src;
  inherit version pubspecLock gitHashes;

  nativeBuildInputs = [
    autoPatchelfHook
    copyDesktopItems
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
    lcms2
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
    xorg.libXScrnSaver
    xorg.libXpresent
    nv-codec-headers-12
    libva
    libvdpau
    libayatana-appindicator
  ];

  preBuild = ''
    cat <<EOL > lib/build_config.dart
    class BuildConfig {
      static const int versionCode = 0;
      static const int buildTime = 0xFFFFFFFF;
      static const String commitHash = '0000000000000000000000000000000000000000';
      static const String versionName = "${version}";
    }
    EOL
  '';
  postInstall = ''
    install -Dm644 assets/images/logo/logo.png $out/share/pixmaps/piliplus.png
  '';

  extraWrapProgramArgs = ''
    --prefix LD_LIBRARY_PATH : $out/app/piliplus/lib:${mpv}/lib
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "piliplus";
      exec = "piliplus";
      icon = "piliplus";
      desktopName = "PiliPlus";
      comment = "Third party Bilibili client built with Flutter";
      categories = [ "AudioVideo" ];
      extraConfig = {
        "Comment[zh_CN]" = "使用 Flutter 开发的 BiliBili 第三方客户端";
        "Comment[zh_TW]" = "使用 Flutter 開發的 BiliBili 第三方客戶端";
      };
    })
  ];

  meta = {
    maintainers = with lib.maintainers; [
      xddxdd
      ccicnce113424
    ];
    description = "Third party Bilibili client built with Flutter";
    homepage = "https://github.com/bggRGjQaUbCoE/PiliPlus";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.unix;
    mainProgram = "piliplus";
  };
}
