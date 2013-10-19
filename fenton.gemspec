# -*- encoding: utf-8 -*-
$:.unshift(File.dirname(__FILE__) + '/lib')
require 'fenton/version'

Gem::Specification.new do |s|
  s.name              = "fenton"
  s.version           = Fenton::VERSION
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Nick Willever"]
  s.email             = ["nickwillever@gmail.com"]
  s.homepage          = ""
  s.summary           = %q{A command line client to manage and sign SSH keys via Fenton Server}
  s.description       = s.summary
  s.extra_rdoc_files  = ["README", "LICENSE" ]
  s.license           = "Apache License, Version 2.0"
  
  s.bindir            = "bin"
  s.executables       = ["fenton"]
  s.require_paths     = ["lib"]
  s.files             = %w(Rakefile LICENSE README) + Dir.glob("{lib}/**/*", File::FNM_DOTMATCH).reject {|f| File.directory?(f) }

  s.add_runtime_dependency "excon", "=0.27.6"
  s.add_runtime_dependency "gli", "=2.8.1"
  s.add_runtime_dependency "highline", "=1.6.20"
  s.add_runtime_dependency "json", "=1.8.1"
end
