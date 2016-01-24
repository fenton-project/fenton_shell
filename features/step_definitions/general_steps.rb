When %r{I get "([^"]*)"} do |action|
  step %(I run `#{@app_name} #{action}`)
end
