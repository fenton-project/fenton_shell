module FentonShell
  # Provides SSH Key generation on the local client
  class Key
    # @!attribute [r] message
    #   @return [String] success or failure message and why
    attr_accessor :message

    # Creates a new key on the local client
    #
    # @param options [Hash] fields to send to ssh key pair generation
    # @return [String] success or failure message

    def create(options)
      status, body = key_create(options)

      if status
        save_message('Key': ['created!'])
        true
      else
        save_message(body)
        false
      end
    end

    private

    # Sends a post request with json from the command line key
    #
    # @param options [Hash] fields from fenton command line
    # @return [Object] true or false
    # @return [String] message on success or failure
    def key_create(options)
      ssh_key = key_generation(options)

      # TODO: - add to .fenton/config file
      File.write(options[:private_key], ssh_key.private_key)
      File.write("#{options[:private_key]}.pub", ssh_key.ssh_public_key)

      [true, 'Key': ['creation failed']]
    end

    # Generates the SSH key pair
    #
    # @param options [Hash] fields from fenton command line
    # @return [String] ssh key pair object created from the options hash
    def key_generation(options)
      SSHKey.generate(
        type: options[:type],
        bits: options[:bits],
        comment: 'ssh@fenton_shell',
        passphrase: options[:passphrase]
      )
    end

    # Helps output the error message from fenton server
    #
    # @param msg [Hash] fields from fenton public classes
    # @return [String] changed hash fields to string for command line output
    def save_message(msg = {})
      self.message ||= ''

      msg.each do |key, value|
        self.message << "#{key.capitalize} #{value.first}\n"
      end
    end
  end
end
