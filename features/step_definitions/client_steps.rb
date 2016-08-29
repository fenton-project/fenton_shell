When %r{I\ssignup\sa\sclient\swith\susername\s
  "([^"]*)"\snamed\s"([^"]*)"\swith\sa\spublic\s
  key}x do |username, client_name|
  command = "#{@app_name} --directory tmp/aruba client signup #{username} " \
    "--name '#{client_name}' --email #{username}@example.com " \
    "--password #{username} --public_key #{@public_key_path}"
  step %(I run `#{command}`)
end

Given %r{a file named "([^"]*)"} do |file|
  step %(I run `cat #{file}`)
end
