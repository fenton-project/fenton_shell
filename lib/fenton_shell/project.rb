module FentonShell
  # Interfaces with the project api on fenton server
  class Project
    # @!attribute [r] message
    #   @return [String] success or failure message and why
    attr_accessor :message

    # Creates a new project on fenton server by sending a post
    # request with json from the command line to create the project
    #
    # @param global_options [Hash] global command line options
    # @param options [Hash] json fields to send to fenton server
    # @return [String] success or failure message

    def create(global_options, options)
      status, body = project_create(global_options, options)

      if status == 201
        save_message(create_success_message(body))
        true
      else
        parse_message(body)
        false
      end
    end

    private

    def create_success_message(body)
      msg = "Project Created! Below is the public key to add to the server.\n\n"
      msg << "#{body['data']['attributes']['ca-public-key']}\n\n"
      msg << "Add the public key above to /etc/ssh/trusted_user_ca_key\n\n"
      msg << "Add this line to /etc/ssh/sshd_config\n"
      msg << "  TrustedUserCAKeys /etc/ssh/trusted_user_ca_key\n\n"
      msg << "Run these commands:\n"
      msg << '  chmod 644 /etc/ssh/trusted_user_ca_key && ' \
      "service ssh restart\n\n"
      msg << 'Now have Fenton Server sign your public key to ' \
      "login to the server\n"
    end

    # Sends a post request with json from the command line client
    #
    # @param global_options [Hash] global command line options
    # @param options [Hash] json fields to send to fenton server
    # @return [Fixnum] http status code
    # @return [String] message back from fenton server
    def project_create(global_options, options)
      result = Excon.post(
        "#{global_options[:fenton_server_url]}/projects.json",
        body: project_json(options),
        headers: { 'Content-Type' => 'application/json' }
      )

      [result.status, JSON.parse(result.body)]
    end

    # Formulates the project json for the post request
    #
    # @param options [Hash] fields from fenton command line
    # @return [String] json created from the options hash
    def project_json(options)
      {
        project: {
          name: options[:name],
          description: options[:description],
          passphrase: options[:passphrase],
          key: options[:key],
          organization: options[:organization]
        }
      }.to_json
    end

    # Helps output the error message from fenton server
    #
    # @param msg [Hash] fields from fenton public classes
    # @return [String] changed hash fields to string for command line output
    def parse_message(msg = {})
      self.message ||= ''

      msg.each do |key, value|
        self.message << "#{key.capitalize} #{value.first}\n"
      end
    end

    def save_message(msg)
      self.message ||= ''
      self.message << msg.to_s
    end
  end
end
