{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = ({ self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
	env = pkgs.buildEnv {
	  name = "art-of-jazz-archiver";
	  paths = [
	    pkgs.coreutils
	    pkgs.bash
	    pkgs.aria2
	    pkgs.rclone
	  ];
	};
      in {
       packages = {
         default = env;
       };
      }
    )
  );
}
