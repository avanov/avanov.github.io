{ nixpkgs ? (import (builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixpkgs-19.09-post-hakyll";
    # Commit hash for nixos-unstable as of 2019-10-27
    url = https://github.com/NixOS/nixpkgs/archive/4aaf2ad527e123e99ecb993130e8458125a6a42f.tar.gz;
    # Hash obtained using `nix-prefetch-url --unpack <url>`
    sha256 = "0h9lbijvzbm30dlzm7y4v6iah5d8bxbw8i6ipsfy6fapyf2l79z0";
  }) {}),
  compiler ? "default",
  doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, hakyll, stdenv }:
      mkDerivation {
        pname = "avanov-github-io";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [ base hakyll ];
        license = "unknown";
        hydraPlatforms = stdenv.lib.platforms.none;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
