{
  description = "Minecraft Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        java = pkgs.jetbrains.jdk-no-jcef;

        nativeBuildInputs = with pkgs; [
          git
        ];
        buildInputs = with pkgs; [
          java
          libGL
          glfw
          xorg.libX11
          xorg.libXext
          xorg.libXcursor
          xorg.libXrandr
          xorg.libXxf86vm
          xorg.xrandr
          glfw3-minecraft
          flite
          libpulseaudio
        ];
      in {
        devShells.default = pkgs.mkShell {
          inherit nativeBuildInputs buildInputs;
          env = {
              LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
              JAVA_HOME = "${java.home}";
            };
        };
      }
    );
}
