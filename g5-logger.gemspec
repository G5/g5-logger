# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'g5/logger/version'

Gem::Specification.new do |spec|
  spec.name     = "g5-logger"
  spec.version  = G5::Logger::VERSION
  spec.authors  = ["Perry Hertler"]
  spec.email    = ["perry@hertler.org"]
  spec.summary  = %q{Client gem that logs to the G5-logging-service.}
  spec.homepage = ""
  spec.license  = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'pry-nav'

  spec.add_runtime_dependency 'typhoeus'
  spec.add_runtime_dependency 'activesupport'
end
