{ stdenv, bash, ruby, bundlerEnv, writeScript }:
let
  env = bundlerEnv {
    name = "hn-rss-ruby-env";
#    inherit ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in
stdenv.mkDerivation rec {
  version = "0.1.0";
  name = "hn-front2rss-${version}";
  meta = {
    maintainer = [ "Maarten Hoogendoorn <maarten@moretea.nl>" ];
    description = "Server that publishes an RSS of yesterday's HN front page stories";
    license = "GPL-3.0";
  };

  buildInputs = [ env.wrappedRuby ];

  buildCommand = ''
    mkdir -p $out/bin
    install -D -m755 ${./bin/hn-front2rss}  $out/bin/hn-front2rss
    patchShebangs $out/bin/hn-front2rss
  '';
}

