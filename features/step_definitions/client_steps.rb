When %r{I create a client for "([^"]*)" with a public key} do |client_name|
  step %(I run `#{@app_name} client create --name '#{client_name}' "\
    "--public_key #{@public_key_path}`)
end
