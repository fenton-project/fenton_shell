# -*- encoding: utf-8 -*-
$:.unshift(File.dirname(__FILE__) + '/lib')
require File.join([File.dirname(__FILE__),'lib','fenton_shell','version.rb'])

Gem::Specification.new do |s|
  s.name              = "fenton_shell"
  s.version           = FentonShell::VERSION
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Nick Willever"]
  s.email             = ["nickwillever@gmail.com"]
  s.homepage          = ""
  s.summary           = %q{A command line client to manage and sign SSH keys via Fenton Server}
  s.description       = s.summary
  s.license           = "Apache License, Version 2.0"

  s.has_rdoc          = true
  s.extra_rdoc_files  = ["README.md", "LICENSE",'fenton_shell.rdoc' ]
  s.rdoc_options      << '--title' << 'fenton' << '--main' << 'README.rdoc' << '-ri'

  s.bindir            = "bin"
  s.executables       = ["fenton"]
  s.require_paths     = ["lib"]
  s.files             = %w(Rakefile LICENSE README.md) + Dir.glob("{lib}/**/*", File::FNM_DOTMATCH).reject {|f| File.directory?(f) }

  s.add_runtime_dependency "excon", "=0.27.6"
  s.add_runtime_dependency "gli", "=2.8.1"
  s.add_runtime_dependency "json", "=1.8.1"

  s.add_development_dependency('rake')
  s.add_development_dependency('aruba')
  s.add_development_dependency('minitest')
  s.add_development_dependency('test-unit')
  s.add_development_dependency('yard')
end
