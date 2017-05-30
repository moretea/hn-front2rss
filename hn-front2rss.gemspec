# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hn-front2rss/version'

Gem::Specification.new do |spec|
  spec.name          = "hn-front2rss"
  spec.version       = HNFront2rss::VERSION
  spec.authors       = ["Maarten Hoogendoorn", "Miko Kuijn"]
  spec.email         = ["maarten@moretea.nl"]

  spec.summary       = %q{Delayed feed from HN}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/moretea/hn-front2rss"
  spec.license       = "GPL3+"

  spec.files         = Dir["#{File.expand_path(__FILE__,"../")}/**/*"]
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_dependency "oga", "~> 2.8"
  spec.add_dependency "sinatra", "~> 1.4"
end
