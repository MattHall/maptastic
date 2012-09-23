# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'maptastic-form/version'
 
Gem::Specification.new do |s|
  s.name        = "maptastic-form"
  s.version     = MaptasticForm::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Hall"]
  s.email       = ["matt@codebeef.com"]
  s.homepage    = "http://codebeef.com/projects/maptastic"
  s.summary     = "The fastest way of adding maps to Formtastic forms"
  s.description = "Provides a map type to Formtastic, allowing you to easily add location selectors to your apps."
 
  s.files        = Dir.glob("{lib,tasks}/**/*") + %w(MIT-LICENSE README.markdown)
  
  s.add_runtime_dependency('formtastic')
end