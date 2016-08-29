Given %r{an\sorganization\snamed\s"([^"]*)"\s
  is\screated\swith\skey\s"([^"]*)"}x do |organization, key|
  command = "#{@app_name} organization create '#{organization}' " \
    "--key #{key}"
  step %(I run `#{command}`)
end

When %r{I\screate\sa\sproject\snamed\s
  "([^"]*)"\swith\skey\s"([^"]*)"\sfor\s
  "([^"]*)"}x do |project_name, key, organization|
  command = "#{@app_name} project create '#{project_name}' " \
    "--description '#{project_name}' --passphrase '#{project_name}' " \
    "--key #{key} --organization #{organization}"
  step %(I run `#{command}`)
end
