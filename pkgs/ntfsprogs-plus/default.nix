{
  sources,
  version,
  callPackage,
}:
let
  ntfsprogs-plus = callPackage ./package.nix { };
in
ntfsprogs-plus.overrideAttrs {
  inherit (sources) pname src;
  inherit version;
}
