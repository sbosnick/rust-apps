# Rust App Flake

**Flake to add addtional rust application to nixpkgs**

## Usage

Add `rust-app.overlays.default` as an overlay to your instantiation of `nixpkgs`
and then make use of `pkgs.rust-apps.{app}`.

## Application bundled

| Name | Description |
| [release-plz] | release manager for rust |

[release-plz]: https://github.com/MarcoIeni/release-plz
