with (import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixpkgs-19.09-post-hakyll";
  # Commit hash for nixos-unstable as of 2019-10-27
  url = https://github.com/NixOS/nixpkgs/archive/4aaf2ad527e123e99ecb993130e8458125a6a42f.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0h9lbijvzbm30dlzm7y4v6iah5d8bxbw8i6ipsfy6fapyf2l79z0";
}) {});

# Make a new "derivation" that represents our shell
mkShell {
    name = "avanov-github-io";

    # https://nixos.org/nixpkgs/manual/#users-guide-to-the-haskell-infrastructure
    buildInputs = [
        # see https://nixos.org/nixos/packages.html
        haskellPackages.hakyll
        cabal2nix
        cabal-install
        which
        gnumake
    ];
    shellHook = ''
        export LANG=en_US.UTF-8
        export LC_ALL=en_US.UTF-8
    '';
}