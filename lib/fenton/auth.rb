module Fenton
  class Auth
    attr_accessor :username, :email, :private_key, :public_key, :private_key_encoded, :public_key_encoded, :public_key_sha, :api_public_key, :api_public_key_encoded

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

      config_contents.store(:username,@username) unless @username.nil?
      config_contents.store(:email,@email) unless @email.nil?
      config_contents.store(:auth_private_key_encoded,@private_key_encoded)
      config_contents.store(:auth_public_key_encoded,@public_key_encoded)
      config_contents.store(:auth_public_key_sha,@public_key_sha)
      config_contents.store(:api_public_key_encoded,@api_public_key_encoded) unless @api_public_key_encoded.nil?

      File.open(file, 'w') { |f| f.write(config_contents.to_yaml) }
    end
  end
end
