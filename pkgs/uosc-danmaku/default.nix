{
  sources,
  version,
  lib,
  buildLua,
  upx,
  autoPatchelfHook,
}:
buildLua (final: {
  inherit (sources) pname src;
  inherit version;

  scriptName = "uosc_danmaku";
  scriptPath = ".";
  passthru.scriptName = final.scriptName;

  nativeBuildInputs = [
    upx
    autoPatchelfHook
  ];

  fixupPhase = ''
    runHook preFixup

    rm -rf $out/share/mpv/scripts/${final.scriptName}/bin/dandanplay/dandanplay.exe
    upx -d $out/share/mpv/scripts/${final.scriptName}/bin/dandanplay/dandanplay

    runHook postFixup
  '';

  meta = {
    changelog = "https://github.com/Tony15246/uosc_danmaku/releases/tag/${final.version}";
    description = "在MPV播放器中加载弹弹play弹幕";
    homepage = "https://github.com/Tony15246/uosc_danmaku";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ccicnce113424 ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [
      fromSource
      # `dandanplay` binary executable is licensed under the MIT license.
      # https://github.com/zhongfly/dandanplay/blob/main/LICENSE
      binaryNativeCode
    ];
  };
})
