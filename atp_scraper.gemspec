# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'atp_scraper/version'

Gem::Specification.new do |spec|
  spec.name          = "atp_scraper"
  spec.version       = AtpScraper::VERSION
  spec.authors       = ["mosuke5"]
  spec.email         = ["w.vamos603@gmail.com"]

  spec.summary       = %q{Scraping tool from ATP tennis site.}
  spec.description   = %q{atp_scraper is a tool scraping tennis data from atpworldtour.com}
  spec.homepage      = "https://github.com/mosuke5/atp_scraper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency "nokogiri"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rb-readline"
  spec.add_development_dependency "rubocop"
end
