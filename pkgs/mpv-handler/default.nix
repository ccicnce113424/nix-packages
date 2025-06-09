{
  sources,
  lib,
  rustPlatform,
  copyDesktopItems,
}:
rustPlatform.buildRustPackage (final: {
  inherit (sources.mpv-handler) pname version src;

  cargoHash = "sha256-FrE1PSRc7GTNUum05jNgKnzpDUc3FiS5CEM18It0lYY=";

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
