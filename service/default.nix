{config, pkgs, lib, ...}:

let
  cfg = config.services.hn-front2rss;
  hn-front2rss = pkgs.callPackage ../. {};
in

with lib;
{

  options = {
    services.hn-front2rss = {
      enable = mkEnableOption "RSS server that shows the top 2 pages that were on Hacker News yesterday";
      port = mkOption {
        type = types.int;
        default = 8042;
        description = "Port on which the service is exposed";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.hn-front2rss = {
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${hn-front2rss}/bin/hn-front2rss -p ${toString cfg.port}";
      };
    };
  };
}
