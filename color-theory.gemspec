# -*- encoding: utf-8 -*-
require File.expand_path("../lib/color-theory/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "color-theory"
  s.version     = Color::Theory::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = []
  s.email       = []
  s.homepage    = "http://rubygems.org/gems/color-theory"
  s.summary     = "TODO: Write a gem summary"
  s.description = "TODO: Write a gem description"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "color-theory"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
