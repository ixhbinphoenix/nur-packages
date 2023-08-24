{ pkgs, fetchFromGithub, lib }:
with pkgs.lib; {
  # Add your library functions here
  #
  # hexint = x: hexvals.${toLower x};
  mk-rust-platform = { date, channel }:
    let
      mozilla-overlay = fetchFromGitHub {
        owner = "mozilla";
        repo = "nixpkgs-mozilla";
        rev = "db89c8707edcffefcd8e738459d511543a339ff5";
        sha256 = lib.fakeSha256;
      };
      mozilla = pkgs.callPackage "${mozilla-overlay.out}/package-set.nix" {};
      rustSpecific = (mozilla.rustChannelOf { inherit date channel ; }).rust;
    in pkgs.makeRustPlatform {
      cargo = rustSpecific;
      rustc = rustSpecific;
    };
}
