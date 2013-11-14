module Fenton
  class Client
    def self.signup(global_options,options,args)
      
    end

    def self.sign(global_options,options,args)
      if ! validate_public(options[:p])
        exit_now!("Invalid public key #{options[:p]}")
      else
        result = Excon.post('http://localhost:9292/key/sign', 
                             :body => URI.encode_www_form(:public => File.read(options[:p])),
                             :headers => { "Content-Type" => "application/x-www-form-urlencoded" })

        result_body = JSON.parse(result.body)
        case result.status
        when 200
          signed_public_key_path = "#{options[:p].gsub('.pub','')}-cert.pub"
          File.open(signed_public_key_path, 'w') { |f| f.write(result_body['signed_public_key']) }
          puts "#{result_body['message']}"
          puts "(#{signed_public_key_path})"
        else
          exit_now!(result_body['message'] || "Signing request failed") #probably make sure sinatra always comes back with this
        end
      end
    end
  end
end
