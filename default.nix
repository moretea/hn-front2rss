{ stdenv, bash, ruby, bundlerEnv, writeScript }:
let
  env = bundlerEnv {
    name = "hn-rss-ruby-env";
    inherit ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
  script = writeScript "hn-front2rss" ''
    #!/${bash}/bin/bash
    ${env}/bin/bundle exec ${ruby}/bin/ruby ${./server.rb} $@
  '';
in
stdenv.mkDerivation rec {
  version = "0.1.0";
  name = "hn-front2rss-${version}";
  meta = {
    maintainer = [ "Maarten Hoogendoorn <maarten@moretea.nl>" ];
    description = "Server that publishes an RSS of yesterday's HN front page stories";
    license = "GPL-3.0";
  };

  phases = "linkPhase";

  linkPhase = ''
    mkdir -p $out/bin
    ln -s ${script} $out/bin/hn-front2rss
  '';
}

