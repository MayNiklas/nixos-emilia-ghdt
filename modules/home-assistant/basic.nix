{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.siren.home-assistant;
in
{
  options.siren.home-assistant = {
    enable = mkEnableOption "basic home-assistant config";
  };
  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 8123 ];

    virtualisation.oci-containers = {
      backend = "podman";
      containers.homeassistant = {
        volumes = [ "home-assistant:/config" ];
        environment.TZ = "Europe/Berlin";
        image = "ghcr.io/home-assistant/home-assistant:stable"; # Warning: if the tag does not change, the image will not be updated
        extraOptions = [ 
          "--network=host"
          "--device=/dev/ttyUSB0:/dev/ttyUSB0"
        ];
      };
    };
  };
}
