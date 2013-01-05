# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "RubyIOC/version"

Gem::Specification.new do |s|
  s.name        = "RubyIOC"
  s.version     = RubyIOC::VERSION
  s.authors     = ["Matt Jezorek"]
  s.email       = ["mjezorek@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{RubyIOC is a ruby library used for indicators of compromise}
  s.description = %q{RubyIOC is a ruby library used for indicators of compromise}

  s.rubyforge_project = "RubyIOC"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
