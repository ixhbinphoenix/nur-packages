{ fetchFromGitHub, lib }:
let src = fetchFromGitHub {
  owner = "ixhbinphoenix";
  repo = "what-the-dog-doin";
  rev = "545989468e8e3571c30425d3b4c2501b52613567";
  sha256 = "sha256-mUMK6NjK8cA+fDdApWwdQRjEk7kz4+4HZUJ3AjDk960=";
};
in
import "${src}/default.nix"
