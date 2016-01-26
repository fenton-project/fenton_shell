When %r{I signup a client with username "([^"]*)" named "([^"]*)" with a public key} do |username,client_name|
  command = "#{@app_name} client signup #{username} " \
    "--name '#{client_name}' --email #{username}@example.com " \
    "--password #{username} --public_key #{@public_key_path}"
  step %(I run `#{command}`)
end
