# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wonder_rails_helpers/version'

Gem::Specification.new do |spec|
  spec.name          = 'wonder_rails_helpers'
  spec.version       = WonderRailsHelpers::VERSION
  spec.authors       = ['Wonder Sistemas']
  spec.email         = ['wonder@wonder.com.br']

  spec.summary       = 'Helpers compartilhados para projetos Rails da Wonder Sistemas.'
  spec.description   = 'Helpers compartilhados para projetos Rails da Wonder Sistemas.'
  spec.homepage      = 'https://www.wonder.com.br'
  spec.license       = 'closed'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rdoc'
end
