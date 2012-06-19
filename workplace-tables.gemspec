# -*- encoding: utf-8 -*-

require File.expand_path('../lib/workplace/tables/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "workplace-tables"
  gem.version       = Workplace::Tables::VERSION
  gem.summary       = %q{TODO: Summary}
  gem.description   = %q{TODO: Description}
  gem.license       = "MIT"
  gem.authors       = ["Max Meyer"]
  gem.email         = "dev@fedux.org"
  gem.homepage      = "https://github.com/maxmeyer/workplace-tables#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'yard', '~> 0.7'
end
