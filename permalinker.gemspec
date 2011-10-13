# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "permalinker/version"

Gem::Specification.new do |s|
  s.name        = "permalinker"
  s.version     = Permalinker::VERSION
  s.authors     = ["Pavel Pravosud"]
  s.email       = ["rwz@duckroll.ru"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "permalinker"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency 'rake'
  s.add_development_dependency 'sqlite3-ruby'
  s.add_runtime_dependency 'activerecord', '>= 3.0.0'
  s.add_runtime_dependency 'activesupport', '>= 3.0.0'
end
