# encoding: UTF-8

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'netverify/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'netverify'
  s.version     = Netverify::VERSION
  s.date        = '2014-03-11'
  s.summary     = 'Netverify'
  s.description = 'Netverify iframe integration'
  s.authors     = ['Lukáš Voda']
  s.email       = 'lvoda@blueberryapps.com'

  s.files      = Dir['{lib}/**/*']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'activesupport'
  s.add_dependency 'virtus'
  s.add_dependency 'json'

  s.add_development_dependency 'rspec', '~> 3.1.0'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'simplecov'
end
