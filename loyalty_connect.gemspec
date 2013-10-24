# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'loyalty_connect/version'

Gem::Specification.new do |spec|
  spec.name          = "loyalty_connect"
  spec.version       = LoyaltyConnect::VERSION
  spec.authors       = ["Jason Clark"]
  spec.email         = ["Jason.Clark@analoganalytics.com"]
  spec.description   = %q{API usage classes for connecting to the Loyalty App}
  spec.summary       = %q{API usage classes for connecting to the Loyalty App}
  spec.homepage      = "http://www.analoganalytics.com/"
  spec.license       = "Private"

  spec.files         = `git ls-files`.split($/).reject { |x| x.start_with?("bin/") } - %w{.gitignore Gemfile.lock}
  spec.executables   = []
  spec.test_files    = spec.files.reject { |x| x.start_with?("test/") }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "oauth2", "0.4.1"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.0.4"
  spec.add_development_dependency "minitest", "~> 4.7.4"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "mocha", "~> 0.14.0"
end
