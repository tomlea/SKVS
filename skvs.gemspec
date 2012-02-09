# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "skvs/version"

Gem::Specification.new do |s|
  s.name        = "skvs"
  s.version     = Skvs::VERSION
  s.authors     = ["Tom Lea"]
  s.email       = ["commit@tomlea.co.uk"]
  s.homepage    = ""
  s.summary     = %q{Simple Key/Value Store}
  s.description = %q{A dirt simple HTTP key value store, with a fancy UI.
  }

  s.rubyforge_project = "skvs"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "redis"
  s.add_runtime_dependency "sinatra"
end
