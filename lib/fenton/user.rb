module Fenton
  class User
    def self.signup(global_options,options,args)
      private_key = RbNaCl::PrivateKey.generate
      private_key_base64 = Base64.urlsafe_encode64(private_key.to_bytes)

      public_key = private_key.public_key
      public_key_base64 = Base64.urlsafe_encode64(public_key.to_bytes)
      public_key_sha512 = Digest::SHA512.hexdigest(public_key.to_bytes)

      result = Excon.post('http://localhost:9292/users/signup', 
                           :body => URI.encode_www_form(:username => options[:username],
                                                        :email => options[:email],
                                                        :auth_public_key => public_key_base64,
                                                        :auth_public_key_sha => public_key_sha512),
                           :headers => { "Content-Type" => "application/x-www-form-urlencoded" })

      result_body = JSON.parse(result.body)

#<Excon::Response:0x000000019b8920 @data={:body=>"{\"response\":200,\"message\":\"User created successfully\",\"api_public_key\":null}", :headers=>{"Content-Type"=>"application/json;charset=utf-8", "Content-Length"=>"76", "X-Content-Type-Options"=>"nosniff", "Server"=>"WEBrick/1.3.1 (Ruby/2.0.0/2013-06-27)", "Date"=>"Thu, 14 Nov 2013 08:58:20 GMT", "Connection"=>"Keep-Alive"}, :status=>200, :remote_ip=>"127.0.0.1"}, @body="{\"response\":200,\"message\":\"User created successfully\",\"api_public_key\":null}", @headers={"Content-Type"=>"application/json;charset=utf-8", "Content-Length"=>"76", "X-Content-Type-Options"=>"nosniff", "Server"=>"WEBrick/1.3.1 (Ruby/2.0.0/2013-06-27)", "Date"=>"Thu, 14 Nov 2013 08:58:20 GMT", "Connection"=>"Keep-Alive"}, @status=200, @remote_ip="127.0.0.1">
# {"response"=>200, "message"=>"User created successfully", "api_public_key"=>nil}

      case result.status
      when 200
        config_contents = { :username => options[:username], :email => options[:email], :auth_public_key_sha => public_key_sha512 }

        File.open("#{global_options[:directory]}/auth.key", 'w') { |f| f.write(private_key_base64) }
        File.open("#{global_options[:directory]}/auth.pub", 'w') { |f| f.write(public_key_base64) }
        File.open("#{global_options[:directory]}/config", 'w') { |f| f.write(config_contents.to_yaml) }
        
        puts result_body['message']
      else
        exit_now! result_body['message']
      end
    end
  end
end
