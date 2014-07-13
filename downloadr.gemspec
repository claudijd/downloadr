# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'downloadr/version'

Gem::Specification.new do |spec|
  spec.name          = "downloadr"
  spec.version       = Downloadr::VERSION
  spec.authors       = ["Jonathan Claudius"]
  spec.email         = ["claudijd@yahoo.com"]
  spec.summary       = %q{A simple gem to make downloading files in a Ruby application simple.}
  spec.description   = %q{A simple gem to make downloading files in a Ruby application simple without needing to roll your own downloader implementation.}
  spec.homepage      = "https://github.com/claudijd/downloadr"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', "~> 1.6"
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'rspec', '~> 0'
end
