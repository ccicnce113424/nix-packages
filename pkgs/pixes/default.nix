{
  sources,
  version,
  lib,
  flutter332,
  makeDesktopItem,
  copyDesktopItems,
}:

flutter332.buildFlutterApplication rec {
  inherit (sources) pname src;
  inherit version;

  pubspecLock = lib.importJSON ./pubspec.lock.json;

  desktopItems = [
    (makeDesktopItem {
      name = "pixes";
      desktopName = "Pixes";
      genericName = "Pixes";
      exec = "pixes %u";
      comment = "Unofficial pixiv application";
      terminal = false;
      categories = [ "Utility" ];
      keywords = [
        "Flutter"
        "share"
        "images"
      ];
      mimeTypes = [ "x-scheme-handler/pixiv" ];
      extraConfig.X-KDE-Protocols = "pixiv";
      icon = "pixes";
    })
  ];

  nativeBuildInputs = [
    copyDesktopItems
  ];

  gitHashes = import ./git-hashes.nix;

  postInstall = ''
    install -D debian/gui/pixes.png $out/share/pixmaps/pixes.png
  '';

  meta = {
    description = "Unofficial pixiv app";
    homepage = "https://github.com/wgh136/pixes";
    changelog = meta.homepage + "/releases/tag/v${version}";
    mainProgram = "pixes";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ccicnce113424 ];
    platforms = lib.platforms.linux;
  };
}
