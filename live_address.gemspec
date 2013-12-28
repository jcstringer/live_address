# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'live_address/version'

Gem::Specification.new do |spec|
  spec.name          = "live_address"
  spec.version       = LiveAddress::VERSION
  spec.authors       = ["Chris Stringer"]
  spec.email         = ["chris.stringer@g5searchmarketing.com"]
  spec.description   = %q{Ruby wrapper for the SmartyStreets LiveAddress API}
  spec.summary       = %q{Creates requests and parses responses to/from the SmartyStreets LiveAddress API using Ruby.}
  spec.homepage      = "https://github.com/jcstringer/live_address"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "httparty"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "mocha"
end
