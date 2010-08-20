# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'organize/version'

Gem::Specification.new do |s|
  s.name        = 'organize'
  s.version     = Organize::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Alexander Kern']
  s.email       = ['alex@kernul.com']
  s.homepage    = 'http://github.com/CapnKernul/organize'
  s.summary     = 'Organize your Mac filesystem'
  s.description = 'Creates directories and links to manage your Mac consistently'
  
  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'organize'
  
  s.add_development_dependency 'bundler', '>= 1.0.0.rc.5'
  
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").select{|f| f =~ /^bin/}
  s.require_path = 'lib'
end