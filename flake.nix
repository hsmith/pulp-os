#  
# SPDX-License-Identifier: MIT
# This file is licensed under the MIT License. 
# You may obtain a copy of the license at https://opensource.org/licenses/MIT.
#

{
  description = "pulp-os developer environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  inputs = {
    smol-epub-src = { url = "github:hansmrtn/smol-epub"; flake = false; };
  };

  outputs = { self, nixpkgs, smol-epub-src }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    env_name = "[pulp]";
  in {
    devShells.${system}.default = (pkgs.buildFHSEnv {
      name = env_name;
      profile = ''
        export PULPOS_DEV_ENV=true
        export SHELL_PREFIX="${env_name}"
        export RUSTUP_TOOLCHAIN=stable
        
        rustup target add riscv32imc-unknown-none-elf

        # dependencies
        mkdir -p .deps
        ln -sfn ${smol-epub-src} .deps/smol-epub
      '';
      targetPkgs = pkgs: [
        pkgs.git
        pkgs.git-lfs
        pkgs.just
        pkgs.esptool
        pkgs.espflash

        pkgs.pkg-config
        pkgs.openssl
        pkgs.libusb1
        pkgs.usbutils

        pkgs.rustup
        pkgs.gcc
      ];
    }).env;
  };
}
