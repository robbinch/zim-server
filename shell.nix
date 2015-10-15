{ nixpkgs ? import <nixpkgs> {}, compiler ? "lts-3_9" }:
(import ./default.nix { inherit nixpkgs compiler; }).env
