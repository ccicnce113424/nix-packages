{
  fetchedSrc,
  lib,
  stdenv,
  appimageTools,
}:
let
  algerSrc = {
    "x86_64-linux" = fetchedSrc.algermusicplayer-x86;
    "aarch64-linux" = fetchedSrc.algermusicplayer-arm;
  };
  sources = algerSrc.${stdenv.hostPlatform.system};
in
appimageTools.wrapType2 rec {
  pname = "algermusicplayer";
  inherit (sources) src version;

  extraInstallCommands =
    let
      appimageContents = appimageTools.extract { inherit pname version src; };
    in
    ''
      mkdir -p $out/share

      install -D ${appimageContents}/algermusicplayer.desktop $out/share/applications/algermusicplayer.desktop
      substituteInPlace $out/share/applications/algermusicplayer.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=algermusicplayer'

      cp -r ${appimageContents}/usr/share/icons $out/share
    '';

  meta = {
    description = "Third-party music player for Netease Cloud Music";
    homepage = "https://github.com/algerkong/AlgerMusicPlayer";
    license = lib.licenses.asl20;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ ccicnce113424 ];
    mainProgram = "algermusicplayer";
    platforms = builtins.attrNames algerSrc;
  };
}
