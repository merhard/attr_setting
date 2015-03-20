# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attr_setting/version'

Gem::Specification.new do |spec|
  spec.name          = "attr_setting"
  spec.version       = AttrSetting::VERSION
  spec.authors       = ["Matthew Erhard"]
  spec.email         = ["merhard@gmail.com"]

  spec.summary       = %q{Enhanced attr_accessor}
  spec.description   = %q{Supplies macro similar to attr_accessor that adds default values, predicate methods, and other enhancements}
  spec.homepage      = "https://github.com/merhard/attr_setting"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.2.0"
end
