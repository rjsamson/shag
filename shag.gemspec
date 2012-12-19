# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shag/version'

Gem::Specification.new do |gem|
  gem.name          = "shag"
  gem.version       = Shag::VERSION
  gem.authors       = ["Robert J Samson"]
  gem.email         = ["rjsamson@me.com"]
  gem.description   = %q{SHAG - Sinatra Heroku App Generator - A stupidly simple, single purpose CLI for generating a scaffold for Sinatra apps on heroku.}
  gem.summary       = %q{A stupidly simple, single purpose CLI for generating a scaffold for Sinatra apps on heroku.}
  gem.homepage      = "https://github.com/rjsamson/shag"

  gem.add_runtime_dependency "thor"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "fakefs"
  gem.add_development_dependency "stub_shell"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
