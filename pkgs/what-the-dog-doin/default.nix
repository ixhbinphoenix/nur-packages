{ pkgs, lib, fetchFromGitHub }:
let
  date = "2023-08-24";
  channel = "nightly";
  mozilla-overlay = fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    rev = "db89c8707edcffefcd8e738459d511543a339ff5";
    sha256 = "sha256-aRIf2FB2GTdfF7gl13WyETmiV/J7EhBGkSWXfZvlxcA=";
  };
  mozilla = pkgs.callPackage "${mozilla-overlay.out}/package-set.nix" {};
  rustSpecific = (mozilla.rustChannelOf { inherit date channel; }).rust;
  platform = pkgs.makeRustPlatform { cargo = rustSpecific; rustc = rustSpecific; };
in
platform.buildRustPackage rec {
  pname = "what-the-dog-doin";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "ixhbinphoenix";
    repo = pname;
    rev = "545989468e8e3571c30425d3b4c2501b52613567";
    sha256 = "sha256-mUMK6NjK8cA+fDdApWwdQRjEk7kz4+4HZUJ3AjDk960=";
  };

  cargoSha256 = "sha256-hxXRHbnU9kfn2xrJg5Xg3INNgbqWgbv5eJcxlYwQ1Fs=";
  verifyCargoDeps = false;

  nativeBuildInputs = with pkgs; [
    pkg-config
    alsa-lib
  ];

  PKG_CONFIG_PATH = "${pkgs.alsa-lib.dev}/lib/pkgconfig";

  meta = with lib; {
    broken = true;
    description = "CLI tool to play sounds in random intervals";
    longDescription = ''
      what-the-dog-doin is a CLI tool that can play any sound in fully customizable intervals.
      '';
    homepage = "https://github.com/ixhbinphoenix/what-the-dog-doin";
    license = with licenses; [ asl20 mit ];
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
