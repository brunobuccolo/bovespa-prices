# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bovespa-prices', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Andrew S Aguiar']
  gem.email         = ['andrewaguiar6@gmail.com']
  gem.description   = 'bovespa-prices is a ruby gem that connects to bovespa to get stock prices'
  gem.summary       = 'bovespa-prices is a ruby gem that connects to bovespa to get stock prices'
  gem.homepage      = 'http://www.github.com/andrewaguiar/bovespa-prices'
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'bovespa-prices'
  gem.require_paths = ['lib']
  gem.version       = Bovespa::VERSION

  gem.add_dependency 'httpclient'
  gem.add_dependency 'nokogiri'
end