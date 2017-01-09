{ bash, ruby, bundlerEnv, writeScriptBin }:
let
  env = bundlerEnv {
    name = "hn-rss-ruby-env";
    inherit ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in
writeScriptBin "hn-front2rss" ''
  #!/${bash}/bin/bash
  ${env}/bin/bundle exec ${ruby}/bin/ruby ${./server.rb} $@
''
