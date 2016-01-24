When %r{I create a project for "([^"]*)"} do |project_name|
  command = "#{@app_name} project create --name '#{project_name}' " \
    "--description '#{project_name}' --passphrase '#{project_name}'"
  step %(I run `#{command}`)
end
