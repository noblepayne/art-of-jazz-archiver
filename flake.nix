{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = ({ self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
	      rcloneConf = pkgs.writeText "rclone.conf" (builtins.readFile ./rclone.conf);
	      downloadScript = builtins.readFile ./downloadDate.sh;
	      uploadScript = ''
	        set -e
	        rclone --config ${rcloneConf} copyto --progress $$WORKDIR/ DO:artofjazz/episodes/
		rm -r $$WORKDIR
	      '';
	      archive = pkgs.writeShellApplication {
	        name = "archive";
	        runtimeInputs = [
	          pkgs.aria2
	          pkgs.coreutils
	          pkgs.rclone
	        ];
	        text = ''
	          ${downloadScript}
	          ${uploadScript}
	        '';
	      };
      in {
       packages = {
         default = archive;
       };
      }
    )
  );
}
