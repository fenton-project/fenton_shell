require 'sshkey'

Before do |scenario|
  next unless scenario.name =~ %r{.*client}
  @public_key_path = "tmp/aruba/client_public_key"
  ::File.write(@public_key_path,
    ::SSHKey.generate(type: "RSA", bits: 256).ssh_public_key)
end

After do |scenario|
  next unless scenario.name =~ %r{.*client}
  ::FileUtils.rm_r(@public_key_path)
end
