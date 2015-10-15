{ nixpkgs ? import <nixpkgs> {}, compiler ? "lts-3_9" }:
nixpkgs.pkgs.haskell.packages.${compiler}.callPackage ./zim-server.nix { }
