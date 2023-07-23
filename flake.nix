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
	    pkgs.aria2
	    pkgs.coreutils
	    pkgs.rclone
	  ];
	};
	archive_script = pkgs.writeShellApplication {
	  name = "archive";
	  runtimeInputs = [ env ];
	  text = builtins.readFile ./archive_date.sh;
	};
      in {
       packages = {
         default = archive_script;
       };
      }
    )
  );
}
