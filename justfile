fmt:
    nix fmt .

fup:
    nix flake update --commit-lock-file 

hello:
    nix run

up:
    nix run nixpkgs#nvfetcher -- -o pkgs/_sources
