{ pkgs ? import <nixpkgs> {}, ci ? false}:
let
	base = (pkgs.nix-pin.api {}).callPackage ./nix/default.nix {};
	extraPackages = with pkgs;
		[ gup base.opam2nixBin nix-pin ] ++ (
			if ci then [ nix-prefetch-scripts ] else []
		);
in
pkgs.stdenv.mkDerivation {
	name = "shell";
	buildInput = extraPackages;
	passthru = base;
}
