Given %r{^an organization named "([^"]*)" is created with key "([^"]*)"} do |organization,key|
  command = "#{@app_name} organization create --name '#{organization}' " \
    "--key #{key}"
  step %(I run `#{command}`)
end

When %r{I create a project named "([^"]*)" with key "([^"]*)" for "([^"]*)"} do |project_name,key,organization|
  command = "#{@app_name} project create --name '#{project_name}' " \
    "--description '#{project_name}' --passphrase '#{project_name}' " \
    "--key #{key} --organization #{organization}"
  step %(I run `#{command}`)
end
