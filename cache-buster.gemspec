# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cache-buster/version'

Gem::Specification.new do |spec|
  spec.name          = "cache-buster"
  spec.version       = CacheBuster::VERSION
  spec.authors       = ["pezholio"]
  spec.email         = ["pezholio@gmail.com"]

  spec.summary       = "♩ ♫ ♩ When a cache gets stuck, and something something else / Who you gonna call? ♩ ♫ ♩"
  spec.homepage      = "https://github.com/theodi/cache-buster"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rubyflare", "~> 0.1.0"
  spec.add_dependency "dotenv", "~> 2.0.2"
  spec.add_dependency "fog-rackspace", "~> 0.1"
  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "pi_piper", "~> 1.9"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 1.24"
  spec.add_development_dependency "coveralls", "~> 0.8"
end
