{
  sources,
  version,
  srcInfo,
  lib,
  flutter344,
  makeDesktopItem,
  copyDesktopItems,
  alsa-lib,
  mpv-unwrapped,
  libplacebo,
  libappindicator,
  webkitgtk_4_1,
}:
let
  majorMinorPatch = v: builtins.concatStringsSep "." (lib.take 3 (builtins.splitVersion v));
in
flutter344.buildFlutterApplication {
  inherit (sources) pname src;
  inherit version;
  inherit (srcInfo) pubspecLock gitHashes;

  patches = [ ./disable-auto-update.patch ];

  nativeBuildInputs = [
    copyDesktopItems
  ];

  buildInputs = [
    alsa-lib
    mpv-unwrapped
    libplacebo
    libappindicator
    webkitgtk_4_1
  ];

  preBuild = ''
    cat <<EOL > lib/build_config.dart
    class BuildConfig {
      static const int versionCode = ${toString srcInfo.revCount};
      static const String versionName = '${majorMinorPatch version}';
      static const int buildTime = ${toString srcInfo.time};
      static const String commitHash = '${srcInfo.rev}';
    }
    EOL
  '';

  postInstall = ''
    declare -A sizes=(
      [mdpi]=128
      [hdpi]=192
      [xhdpi]=256
      [xxhdpi]=384
      [xxxhdpi]=512
    )
    for var in "''${!sizes[@]}"; do
      width=''${sizes[$var]}
      install -Dm644 "android/app/src/main/res/drawable-$var/splash.png" \
        "$out/share/icons/hicolor/''${width}x$width/apps/pilinara.png"
    done
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "com.example.pilinara";
      type = "Application";
      desktopName = "PiliNara";
      comment = "A third-party Bilibili Client developed in Flutter";
      extraConfig = {
        "Comment[zh_CN]" = "使用 Flutter 开发的 BiliBili 第三方客户端";
      };
      exec = "pilinara";
      icon = "pilinara";
      terminal = false;
      startupWMClass = "com.example.pilinara";
      categories = [
        "Video"
        "AudioVideo"
        "Player"
      ];
    })
  ];

  meta = {
    description = "A third-party Bilibili Client developed in Flutter";
    homepage = "https://github.com/Starfallan/PiliNara";
    changelog = "https://github.com/Starfallan/PiliNara/releases/tag/${version}";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [
      ccicnce113424
    ];
    platforms = lib.platforms.linux;
    mainProgram = "pilinara";
  };
}
