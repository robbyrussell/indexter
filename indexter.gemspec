# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'indexter/version'

Gem::Specification.new do |gem|
  gem.name          = "indexter"
  gem.version       = Indexter::VERSION
  gem.authors       = ["Chris Cummer"]
  gem.email         = ["chriscummer@me.com"]

  gem.summary       = "Checks Rails databases tables for missing indexes on possible foreign keys."
  gem.description   = "Checks Rails databases tables for missing indexes on possible foreign keys."
  gem.homepage      = "https://github.com/senorprogrammer/indexter"
  gem.license       = "MIT"

  gem.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  gem.bindir        = "exe"
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ["lib"]

  # Production dependencies
  gem.add_dependency "activerecord",   ">= 3.0.0"
  gem.add_dependency "sqlite3",        ">= 1.3.9"
  gem.add_dependency "rainbow",        "~> 2.1.0"
  gem.add_dependency "terminal-table", "~> 1.7.0"

  # Development dependencies
  gem.add_development_dependency "rake", "~> 12.0"
  gem.add_development_dependency "rspec", "~> 3.5"
end
