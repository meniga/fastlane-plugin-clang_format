# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/clang_format/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-clang_format'
  spec.version       = Fastlane::ClangFormat::VERSION
  spec.author        = 'Meniga'
  spec.email         = 'mobile.dev@meniga.com'

  spec.summary       = 'Format your C/C++/Java/JavaScript/Objective-C/Protobuf/C code with clang-format'
  spec.homepage      = "https://github.com/meniga/fastlane-plugin-clang_format"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency('pry')
  spec.add_development_dependency('bundler')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rspec_junit_formatter')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('rubocop', '1.4.1')
  spec.add_development_dependency('rubocop-require_tools')
  spec.add_development_dependency('simplecov')
  spec.add_development_dependency('fastlane', '>= 2.142.0')
  spec.add_development_dependency('codecov')
end
