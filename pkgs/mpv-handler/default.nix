{
  sources,
  lib,
  rustPlatform,
  copyDesktopItems,
}:
rustPlatform.buildRustPackage (final: {
  inherit (sources.mpv-handler) pname version src;

  cargoLock = sources.mpv-handler.cargoLock."Cargo.lock";

  nativeBuildInputs = [ copyDesktopItems ];
  desktopItems = [
    "${final.src}/share/linux/mpv-handler.desktop"
    "${final.src}/share/linux/mpv-handler-debug.desktop"
  ];

  meta = {
    description = "Protocol handler for mpv";
    homepage = "https://github.com/akiirui/mpv-handler";
    license = lib.licenses.mit;
  };
})
