# May use in the future, keeping for examples
# module FentonShell
#   class Key
#     def self.decode(key)
#       return Base64.urlsafe_decode64(key)
#     end

#     def self.encode(key)
#       return Base64.urlsafe_encode64(key)
#     end

#     def self.sha(key)
#       return Digest::SHA512.hexdigest(key)
#     end

#     def self.validate_public(public_key)
#       return true #maybe later
#     end

#     def self.ca_public_key(global_options,options,args)
#       result = Excon.get("#{global_options[:fenton_server_url]}/key/ca_public_key")

#       result_body = JSON.parse(result.body)
#       case result.status
#       when 200
#         puts result_body['ca_public_key']
#       else
#         exit_now!(result_body['message'])
#       end
#     end

#     def self.sign(global_options,options,args)
#       if ! validate_public(options[:p])
#         exit_now!("Invalid public key #{options[:p]}")
#       else
#         result = Excon.post("#{global_options[:fenton_server_url]}/key/sign",
#                              :body => URI.encode_www_form(:public => File.read(options[:p])),
#                              :headers => { "Content-Type" => "application/x-www-form-urlencoded" })

#         result_body = JSON.parse(result.body)
#         case result.status
#         when 200
#           signed_public_key_path = "#{options[:p].gsub('.pub','')}-cert.pub"
#           File.open(signed_public_key_path, 'w') { |f| f.write(result_body['signed_public_key']) }
#           puts "#{result_body['message']}"
#           puts "(#{signed_public_key_path})"
#         else
#           exit_now!(result_body['message'] || "Signing request failed") #probably make sure sinatra always comes back with this
#         end
#       end
#     end
#   end
# end
