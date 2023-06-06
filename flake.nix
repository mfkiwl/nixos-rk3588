{
  description = "A minimal NixOS configuration for the RK3588/RK3588S based SBCs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05-small";

    # GPU drivers
    mesa-panfork = {
      url = "gitlab:panfork/mesa/csf";
      flake = false;
    };

    linux-rockchip = {
      url = "github:armbian/linux-rockchip/rk-5.10-rkr4";
      flake = false;
    };
  };

  outputs = inputs@{nixpkgs, ...}: {
    nixosConfigurations = {
      # Orange Pi 5 SBC
      orangepi5 = import "${nixpkgs}/nixos/lib/eval-config.nix" rec {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules =
          [
            {
              networking.hostName = "orangepi5";
            }

            ./modules/orangepi5.nix
          ];
      };

      # Orange Pi 5 Plus SBC
      # TODO not complete yet
      orangepi5plus = import "${nixpkgs}/nixos/lib/eval-config.nix" rec {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules =
          [
            {
              networking.hostName = "orangepi5plus";
            }

            ./modules/orangepi5plus.nix
          ];
      };

      # Rock 5 Model A SBC
      # TODO not complete yet
      rock5a = import "${nixpkgs}/nixos/lib/eval-config.nix" rec {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules =
          [
            {
              networking.hostName = "rock5a";
            }

            ./modules/rock5a.nix
          ];
      };
    };
  };
}
