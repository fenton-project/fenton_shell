# -*- encoding: utf-8 -*-
$:.unshift(File.dirname(__FILE__) + '/lib')
require File.join([File.dirname(__FILE__),'lib','fenton_shell','version.rb'])

Gem::Specification.new do |s|
  s.name              = "fenton_shell"
  s.version           = FentonShell::VERSION
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Nick Willever"]
  s.email             = ["nickwillever@gmail.com"]
  s.homepage          = "https://github.com/fenton-project/fenton_shell"
  s.summary           = %q{A command line client to manage and sign SSH keys via Fenton Server}
  s.description       = s.summary
  s.license           = "Apache License, Version 2.0"

  s.cert_chain        = ['certs/nictrix.pem']
  s.signing_key       = File.join(Gem.user_home, ".ssh", "gem-private_key.pem") if $0 =~ /gem\z/

  s.has_rdoc          = true
  s.rdoc_options      = ["--charset=UTF-8"]
  s.extra_rdoc_files  = %w(README.md LICENSE)

  s.bindir            = "bin"
  s.executables       = ["fenton"]
  s.require_paths     = ["lib"]
  s.files             = %w(Rakefile LICENSE README.md) + Dir.glob("{lib}/**/*", File::FNM_DOTMATCH).reject {|f| File.directory?(f) }

  s.add_runtime_dependency "excon", "~>0.45.4"
  s.add_runtime_dependency "gli", "~>2.13.4"
  s.add_runtime_dependency "json", "~>1.8.3"
  s.add_runtime_dependency "sshkey", "~>1.8.0"
  s.add_runtime_dependency "highline", "~>1.7.8"

  s.add_development_dependency('rake')
  s.add_development_dependency('aruba')
  s.add_development_dependency('minitest')
  s.add_development_dependency('test-unit')
  s.add_development_dependency('yard')
  s.add_development_dependency('rubocop')
end
