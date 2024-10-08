{ lib, pkgs, config, system-config, ... }:
with lib;
let cfg = config.siren.programs.shell;
in
{
  options.siren.programs.shell = {
    enable = mkEnableOption "shell config";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {};
    };

    home.packages = with pkgs.fishPlugins; [
      sponge
    ];
  };
}
