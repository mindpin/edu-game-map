# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'edu-game-map/version'

Gem::Specification.new do |spec|
  spec.name          = "edu-game-map"
  spec.version       = EduGameMap::VERSION
  spec.authors       = ["fushang318"]
  spec.email         = ["fushang318@gmail.com"]
  spec.summary       = %q{Progression map for online education services.}
  spec.description   = %q{在线教育学习进度地图。}
  spec.homepage      = "https://github.com/mindpin/edu-game-map"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mongoid", "~> 4.0"
  spec.add_dependency "json"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake",    "~> 10.0"
end
