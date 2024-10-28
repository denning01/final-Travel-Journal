{
  description = "Development environment for a Flask Python server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python311
            python311Packages.flask
            python311Packages.pip
            git
            
            # Development tools
            python311Packages.flake8
            python311Packages.pylint
            python311Packages.ipython
          ];

          shellHook = ''
            export PIP_TARGET="$PWD/vendor"
            export PATH="$PIP_TARGET/bin:$PATH"
            
            # Initialize a Flask app if it doesn't exist
            if [ ! -f "app.py" ]; then
              echo "from flask import Flask, jsonify" > app.py
              echo "app = Flask(__name__)" >> app.py
              echo "@app.route('/')" >> app.py
              echo "def home():" >> app.py
              echo "    return jsonify({'message': 'Hello, World!'})" >> app.py
            fi
          '';
        };
      }
    );
}
