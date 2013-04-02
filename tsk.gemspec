# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tsk/version'

Gem::Specification.new do |spec|
  spec.name          = "tsk"
  spec.version       = Tsk::VERSION
  spec.authors       = ["Mike Anderson"]
  spec.email         = ["athaeryn@me.com"]
  spec.description   = "Tsk tsk tsk... track your time."
  spec.summary       = "A simple time tracker." 
  spec.homepage      = "https://github.com/athaeryn/tsk"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
