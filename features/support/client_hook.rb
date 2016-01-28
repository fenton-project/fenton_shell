require 'sshkey'

Before do |scenario|
  next unless scenario.name =~ %r{.*client}
  @public_key_path = File.join(
    File.expand_path(
      File.dirname(__FILE__)
    ),
    '..', '..', 'tmp', 'aruba', 'client_public_key'
  )
  k = ::SSHKey.generate(type: 'RSA', bits: 256)
  ::File.write(@public_key_path, k.ssh_public_key)
end
