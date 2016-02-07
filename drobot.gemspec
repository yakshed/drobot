# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/version'

Gem::Specification.new do |spec|
  spec.name          = "drobot"
  spec.version       = Drobot::VERSION
  spec.authors       = ["Sebastian Schulze", "Lucas Dohmen"]
  spec.email         = ["rubygems.org@bascht.com", "lucas@moonbeamlabs.com"]
  spec.summary       = "Clever little Robot that downloads your Documents"
  spec.description   = "Clever little Robot that downloads your Documents and can't be bothered to write a description."
  spec.homepage      = "http://www.yakshed.org"
  spec.license       = "GPL-3.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency "poltergeist", "~> 1.9"
  spec.add_dependency "json-schema", "~> 2.5.0"
  spec.add_dependency "erubis", "~> 2.7.0"
  spec.add_dependency "json", "~> 1.8.3"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "awesome_print", "~> 1.6"
  spec.add_development_dependency "sinatra", "~> 1.4"
  spec.add_development_dependency "xdg", "~> 2.1"
end
