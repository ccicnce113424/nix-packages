{
  sources,
  version,
  hash,
  lib,
  stdenv,
  rustPlatform,
  cargo-tauri,
  pnpm_9,
  fetchPnpmDeps,
  pnpmConfigHook,
  nodejs_20,
  pkg-config,
  glib-networking,
  openssl,
  webkitgtk_4_1,
  libayatana-appindicator,
  wrapGAppsHook4,
}:
let
  pnpm = pnpm_9;
  nodejs = nodejs_20;
in
rustPlatform.buildRustPackage (finalAttrs: {
  inherit (sources) pname src;
  inherit version;

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    inherit hash;
    inherit pnpm;
    fetcherVersion = 3;
  };
  cargoDeps = rustPlatform.importCargoLock sources.cargoLock."src-tauri/Cargo.lock";

  nativeBuildInputs = [
    cargo-tauri.hook

    pnpmConfigHook
    pnpm
    nodejs

    pkg-config
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [ wrapGAppsHook4 ];

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    glib-networking
    openssl
    webkitgtk_4_1
    libayatana-appindicator
  ];

  cargoRoot = "src-tauri";
  buildAndTestSubdir = finalAttrs.cargoRoot;

  preFixup = lib.optionalString stdenv.hostPlatform.isLinux ''
    gappsWrapperArgs+=(
      --set-default __NV_DISABLE_EXPLICIT_SYNC 1
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          libayatana-appindicator
        ]
      }
    )
  '';

})
