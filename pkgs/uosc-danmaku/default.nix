{
  lib,
  buildLua,
  fetchFromGitHub,
  gitUpdater,
  danmakufactory,
  opencc,
}:
buildLua (final: {
  pname = "uosc_danmaku";
  version = "1.3.1";
  scriptPath = ".";

  src = fetchFromGitHub {
    owner = "Tony15246";
    repo = "uosc_danmaku";
    rev = "v${final.version}";
    hash = "sha256-m+HubIlELU/COP5rgul7LBPaOEWGz2ms89mF/w3ZWGQ=";
  };

  fixupPhase = ''
    runHook preFixup

    rm -rf $out/share/mpv/scripts/${final.pname}/bin/DanmakuFactory/*
    ln -sf ${danmakufactory}/bin/DanmakuFactory $out/share/mpv/scripts/${final.pname}/bin/DanmakuFactory

    rm -rf $out/share/mpv/scripts/${final.pname}/bin/OpenCC_Windows
    rm -rf $out/share/mpv/scripts/${final.pname}/bin/OpenCC_Linux/*
    ln -sf ${opencc}/bin/opencc $out/share/mpv/scripts/${final.pname}/bin/OpenCC_Linux

    rm -rf $out/share/mpv/scripts/${final.pname}/bin/dandanplay/dandanplay.exe

    runHook postFixup
  '';

  passthru.scriptName = final.pname;
  passthru.updateScript = gitUpdater { rev-prefix = "v"; };

  meta = {
    description = "在MPV播放器中加载弹弹play弹幕";
    homepage = "https://github.com/slqy123/uosc_danmaku";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [
      fromSource
      # `dandanplay` binary executable is licensed under the MIT license.
      # https://github.com/zhongfly/dandanplay/blob/main/LICENSE
      binaryNativeCode
    ];
  };
})
