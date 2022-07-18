{
  description = "Packaging for rust applications not on NixPkgs.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      release-plz = {
        lib, stdenv, rustPlatform, 
        pkg-config, openssl, fetchFromGitHub
      }: rustPlatform.buildRustPackage rec {
        pname = "release-plz";
        version = "0.2.19";

        src = fetchFromGitHub {
          owner = "MarcoIeni";
          repo = pname;
          rev = "${pname}-v${version}";
          sha256 = "sha256-YsJmaASz+9DR6OjkWVTW6WGiXHAS6qp+xkN8GEW+kEQ=";
        };

        cargoSha256 = "sha256-1ISDD2zU+k6QA5auu4r3u0/yJ0MFyvGOO/Rhx3J24yo=";

        nativeBuildInputs = [ pkg-config ];
        buildInputs = [ openssl ];
        };
    in {
      overlays.default = final: prev: {
        rust-apps.release-plz = prev.callPackage release-plz {};
      };
    } // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages = {
        release-plz = pkgs.callPackage release-plz { };
        default = pkgs.callPackage release-plz { };
      };
    });
 }
