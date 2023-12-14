{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/user/ai.nix
    ../../modules/user/alacritty
    ../../modules/user/blender.nix
    ../../modules/user/common-packages.nix
    ../../modules/user/common-ssh.nix
    ../../modules/user/discord.nix
    ../../modules/user/firefox.nix
    ../../modules/user/git.nix
    ../../modules/user/gpg-agent.nix
    ../../modules/user/keepass.nix
    #../../modules/user/pytorch.nix
    ../../modules/user/shell
    ../../modules/user/tor-browser.nix
    ../../modules/user/video.nix
    ../../modules/user/vim.nix
    ../../modules/user/x11
  ];

  home = {
    username = "x";
    homeDirectory = "/home/x";
    stateVersion = "23.05";
  };
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [ (final: prev: {
  #inputs.nixified-ai.packages.overlays = [ (final: prev: {
    grpc = prev.grpc.overrideAttrs (old: {
      version = "1.59.1";
      src = pkgs.fetchFromGitHub {
        owner = "grpc";
        repo = "grpc";
        rev = "v1.59.1";
        hash = "sha256-4bou7oFQOgyxjFqJdmiFT8xEMCsOap9v34W6SPrT4WQ=";
        fetchSubmodules = true;
      };
    });

    python311 = prev.python311.override {
      packageOverrides = final: prev: {
        grpcio = prev.buildPythonPackage rec {
          pname = "grpcio";
          version = "1.59.0";
          src = prev.fetchPypi {
            inherit pname version;
            hash = "sha256-rPcKY88J3UlAAAB7eYr/iKQ24cA7OUmVzkUL5De45U8=";
          };
        };

        grpcio-status = prev.buildPythonPackage rec {
          pname = "grpcio-status";
          version = "1.59.0";
          src = prev.fetchPypi {
            inherit pname version;
            hash = "sha256-+TucM+CiYWLvhDG/z/zD4fshfM2Ne1swYbbp+BPmmLU=";
          };
        };

        grpcio-tools = prev.buildPythonPackage rec {
          pname = "grpcio-tools";
          version = "1.59.0";
          src = prev.fetchPypi {
            inherit pname version;
            hash = "sha256-qkAY8thmKsTZgwRF09JToRs+CW6K/iCGVUcTeqEWDpM=";
          };
        };

      };
    };

  })];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # net
    persepolis
    dropbox

    # office
    libreoffice

    # art
    gimp

    # misc
    xygrib
  ];

  programs.ssh = {
    matchBlocks = {
      "adamantium" = {
        hostname = "adamantium.boxchop.city";
        user = "root";
        port = 2222;
        identityFile = "/home/x/.ssh/id_xbox";
      };
      "github.com" = {
        hostname = "github.com";
        port = 22;
        identityFile = "/home/x/.ssh/id_xbox";
      };
    };
  };

}
