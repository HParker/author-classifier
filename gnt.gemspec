# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gnt/version'

Gem::Specification.new do |spec|
  spec.name          = 'gnt'
  spec.version       = Gnt::VERSION
  spec.authors       = ['Adam Hess']
  spec.email         = ['adamhess1991@gmail.com']
  spec.summary       = 'Gnt is a simple autor detection library.'
  spec.description   = "I'll tell you more when I know more"
  spec.homepage      = 'https://github.com/HParker/gnt'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'engtagger'
  spec.add_dependency 'fast-stemmer'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
