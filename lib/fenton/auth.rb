module Fenton
  class Auth
    attr_accessor :username, :email, :private_key, :public_key, :private_key_encoded, :public_key_encoded, :public_key_sha, :api_public_key, :api_public_key_encoded, :fenton_server_url

    def initialize(attributes=nil)
      if attributes != nil
        @username = attributes[:username]
        @email = attributes[:email]

        @private_key_encoded = attributes[:auth_private_key_encoded]
        @public_key_encoded = attributes[:auth_public_key_encoded]
        @api_public_key_encoded = attributes[:api_public_key_encoded]

        @private_key = Key.decode(@private_key_encoded)
        @public_key = Key.decode(@public_key_encoded)
        @api_public_key = Key.decode(@api_public_key_encoded)
        @public_key_sha = Key.sha(@public_key)

        @fenton_server_url = 'http://localhost:9292'

        return false if attributes[:auth_public_key_sha] != @public_key_sha
      end
    end

    def generate(private_key=nil)
      raw = (private_key.nil? ? RbNaCl::PrivateKey.generate : RbNaCl::PrivateKey.new(private_key).generate)

      @private_key = raw.to_bytes
      @private_key_encoded = Key.encode(@private_key)
      @public_key = raw.public_key.to_bytes
      @public_key_encoded = Key.encode(@public_key)
      @public_key_sha = Key.sha(@public_key)

      return self
    end

    def self.get(file)
      return self.new(YAML.load_file(file)) if File.exists?(file)
    end

    def save(file)
      config_contents = File.exists?(file) ? YAML.load_file(file) : {}

      config_contents.store(:auth_private_key_encoded,@private_key_encoded)
      config_contents.store(:auth_public_key_encoded,@public_key_encoded)
      config_contents.store(:auth_public_key_sha,@public_key_sha)

      config_contents.store(:username,@username) unless @username.nil?
      config_contents.store(:email,@email) unless @email.nil?
      config_contents.store(:api_public_key_encoded,@api_public_key_encoded) unless @api_public_key_encoded.nil?
      config_contents.store(:fenton_server_url,@fenton_server_url) unless @fenton_server_url.nil?

      File.open(file, 'w') { |f| f.write(config_contents.to_yaml) }
    end

    def send_encoded_message(username,message)
      message_key_encoded, message_encoded = encode_message(message)

      return send(username,message_key_encoded,message_encoded)
    end

    def encode_message(message)
      box = RbNaCl::Box.new(@api_public_key, @private_key)
      nonce = RbNaCl::Random.random_bytes(box.nonce_bytes)
      nonce_encoded = Key.encode(nonce)

      message_encoded = Key.encode(message.to_s)

      ciphertext = box.encrypt(nonce, message_encoded)
      ciphertext_encoded = Key.encode(ciphertext)

      return nonce_encoded, ciphertext_encoded
    end

    def send(username,message_key_encoded,message_encoded)
      puts @fenton_server_url

      result = Excon.post("#{@fenton_server_url}/users/update", 
                           :body => URI.encode_www_form(:username => username,
                                                        :message_key_encoded => message_key_encoded,
                                                        :message_encoded => message_encoded
                                                       ),
                           :headers => { "Content-Type" => "application/x-www-form-urlencoded" })
      return result
    end
  end
end
