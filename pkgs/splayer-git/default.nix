{
  sources,
  version,
  hash,
  splayer,
  electron,
}:
splayer.overrideAttrs (
  final: _prev: {
    inherit (sources) pname src;
    inherit version;
    pnpmDeps = final.pnpm.fetchDeps {
      inherit (final) pname version src;
      inherit hash;
      fetcherVersion = 2;
    };

    buildPhase = ''
      runHook preBuild

      pnpm build

      npm exec electron-builder -- \
          --dir \
          --config electron-builder.config.ts \
          -c.electronDist=${electron.dist} \
          -c.electronVersion=${electron.version}

      runHook postBuild
    '';
  }
)
