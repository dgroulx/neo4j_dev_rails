# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'neo4j_dev_rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'neo4j_dev_rails'
  spec.version       = Neo4jDevRails::VERSION
  spec.authors       = ['David Groulx']
  spec.email         = ['david@sandbendersoftware.com']
  spec.description   = %q{Setup Neo4j within a Rails development environment}
  spec.summary       = %q{Setup Neo4j within a Rails development environment}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rails'
end
