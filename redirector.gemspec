# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "redirector/version"

Gem::Specification.new do |s|
  s.name        = "redirector"
  s.version     = Redirector::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Gustav Jonsson"]
  s.email       = ["gustav@invoke.se"]
  s.homepage    = ""
  s.summary     = %q{generates redirect action for resources}
  s.description = %q{generates redirect action for resources}

  s.rubyforge_project = "redirector"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
end
