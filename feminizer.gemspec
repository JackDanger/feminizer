# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "feminizer/version"

Gem::Specification.new do |s|
  s.name        = "feminizer"
  s.version     = Feminizer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jack Danger Canty"]
  s.email       = ["rubygems@6brand.com"]
  s.homepage    = "http://github.com/JackDanger/feminizer"
  s.summary     = %q{Programmatically swap the gender of an English text string}
  s.description = %q{This library can take a piece of English text as a string and swap masculine words for feminine and vice-versa.}

  s.rubyforge_project = "feminizer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
