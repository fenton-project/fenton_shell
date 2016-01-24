# May use in the future, keeping for examples
# module FentonShell
#   class User
#     def self.update(global_options,options,args)
#       old_key = Auth.get("#{global_options[:directory]}/config")
#       new_key = Auth.new.generate

#       message = {}
#       message.store("auth_public_key_encoded",new_key.public_key_encoded)
#       message.store("email",options[:email])

#       result = old_key.send_encoded_message(options[:username],message)
#       result_body = JSON.parse(result.body)

#       case result.status
#       when 200
#         new_key.save("#{global_options[:directory]}/config")
#         puts result_body['message']
#       else
#         exit_now! result_body['message']
#       end
#     end

#     def self.signup(global_options,options,args)
#       key = Auth.new.generate

#       result = Excon.post("#{global_options[:fenton_server_url]}/users/signup",
#                            :body => URI.encode_www_form(:username => options[:username],
#                                                         :email => options[:email],
#                                                         :auth_public_key_encoded => key.public_key_encoded,
#                                                         :auth_public_key_sha => key.public_key_sha),
#                            :headers => { "Content-Type" => "application/x-www-form-urlencoded" })

#       result_body = JSON.parse(result.body)

#       case result.status
#       when 200
#         key.username = options[:username]
#         key.email = options[:email]
#         key.api_public_key_encoded = result_body['api_public_key_encoded']
#         key.save("#{global_options[:directory]}/config")

#         puts result_body['message']
#       else
#         exit_now! result_body['message']
#       end
#     end
#   end
# end
