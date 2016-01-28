When %r{I\screate\sa\s"([^"]*)"\sbit\s
  "([^"]*)"\skey\sfor\s"([^"]*)"\s
  with\spassphrase\sof\s"([^"]*)"}x do |bits, type, private_key, passphrase|
  command = "#{@app_name} keys generate --private_key " \
    "'#{File.expand_path File.dirname(__FILE__) + private_key}' " \
    "--type #{type} --bits #{bits} --passphrase #{passphrase}"
  step %(I run `#{command}`)
end
