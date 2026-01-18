{
  sources,
  version,
  hash,
  pnpm_10,
  fetchPnpmDeps,
  rustPlatform,
  lib,
  electron,
  removeReferencesTo,
  python3,
  wasm-pack,
  rustc,
  binaryen,
  splayer,
  pkgs,
}:
let
  inherit (sources) src;
  wasm-bindgen-cli_0_2_108 = pkgs.callPackage (
    {
      buildWasmBindgenCli,
      fetchCrate,
      rustPlatform,
    }:

    buildWasmBindgenCli rec {
      src = fetchCrate {
        pname = "wasm-bindgen-cli";
        version = "0.2.108";
        hash = "sha256-UsuxILm1G6PkmVw0I/JF12CRltAfCJQFOaT4hFwvR8E=";
      };

      cargoDeps = rustPlatform.fetchCargoVendor {
        inherit src;
        inherit (src) pname version;
        hash = "sha256-iqQiWbsKlLBiJFeqIYiXo3cqxGLSjNM8SOWXGM9u43E=";
      };
    }
  ) { };
in
splayer.overrideAttrs (
  final: prev: {
    inherit (sources) pname;
    inherit src version;
    pnpmDeps = fetchPnpmDeps {
      inherit (final) pname version src;
      inherit hash;
      pnpm = pnpm_10;
      fetcherVersion = 2;
    };
    cargoDeps = rustPlatform.importCargoLock {
      lockFile = ./SPlayer/Cargo.lock;
      outputHashes = {
        "ferrous-opencc-0.3.1" = "sha256-tvMR96vtGRFRflGWmEqLa8y+RvOJcSIJQ0YFDELp5bY=";
      };
    };

    # remove when splayer in nixpkgs has been updated
    nativeBuildInputs = prev.nativeBuildInputs ++ [
      python3
      wasm-pack
      wasm-bindgen-cli_0_2_108
      rustc.llvmPackages.lld
      binaryen
    ];

    # TODO: add env to build.rollupOptions.external in electron.vite.config.ts
    buildPhase = ''
      runHook preBuild      


      # After the pnpm configure, we need to build the binaries of all instances
      # of better-sqlite3. It has a native part that it wants to build using a
      # script which is disallowed.
      # What's more, we need to use headers from electron to avoid ABI mismatches.
      # Adapted from mkYarnModules.env.SKIP_NATIVE_BUILD
      for f in $(find . -path '*/node_modules/better-sqlite3' -type d); do
        (cd "$f" && (
        pnpm run build-release --offline --nodedir="${electron.headers}"
        find build -type f -exec \
          ${lib.getExe removeReferencesTo} \
          -t "${electron.headers}" {} \;
        ))
      done

      pnpm --filter external-media-integration build

      pushd native/ferrous-opencc-wasm
      CFLAGS_wasm32_unknown_unknown="-Wno-implicit-function-declaration" \
        wasm-pack build --target web
      popd

      SKIP_NATIVE_BUILD=true pnpm build

      npm exec electron-builder -- \
          --dir \
          --config electron-builder.config.ts \
          -c.electronDist=${electron.dist} \
          -c.electronVersion=${electron.version}

      runHook postBuild
    '';

    meta = prev.meta // {
      sourceProvenance = with lib.sourceTypes; [
        fromSource
        # public/wasm/decode-audio.wasm
        # source: https://github.com/apoint123/ffmpeg-audio-player
        binaryBytecode
      ];
    };
  }
)
