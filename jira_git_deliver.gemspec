# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jira_git_deliver/version'

Gem::Specification.new do |spec|
  spec.name          = "jira_git_deliver"
  spec.version       = JiraGitDeliver::VERSION
  spec.authors       = ["Ken Liu"]
  spec.email         = ["ken@vts.com"]
  spec.summary       = ""
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "jira-ruby"
  spec.add_runtime_dependency 'dotenv'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "pry"
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
