module FentonShell
  # Interfaces with the certificate api on fenton server
  class Certificate
    # @!attribute [r] message
    #   @return [String] success or failure message and why
    attr_accessor :message

    # Creates a new certificate on fenton server by sending a post
    # request with json from the command line to create the certificate
    #
    # @param global_options [Hash] global command line options
    # @param options [Hash] json fields to send to fenton server
    # @return [String] success or failure message
    def create(global_options, options)
      status, body = certificate_create(global_options, options)

      if status == 201
        save_message('Certificate': ['created!'])
        true
      else
        save_message(body)
        false
      end
    end

    private

    # Sends a post request with json from the command line certificate
    #
    # @param global_options [Hash] global command line options
    # @param options [Hash] json fields to send to fenton server
    # @return [Fixnum] http status code
    # @return [String] message back from fenton server
    def certificate_create(global_options, options)
      result = Excon.post(
        "#{global_options[:fenton_server_url]}/certificates.json",
        body: certificate_json(options),
        headers: { 'Content-Type' => 'application/json' }
      )

      write_client_certificate(
        public_key_cert_location(options[:public_key]),
        JSON.parse(result.body)['data']['attributes']['certificate']
      )

      [result.status, JSON.parse(result.body)]
    end

    def write_client_certificate(file_path, content)
      File.write(file_path, content)
      File.chmod(0o600, file_path)
    end

    def public_key_cert_location(public_key_location)
      public_key_location.gsub(%r{\.pub}, '-cert.pub')
    end

    # Formulates the certificate json for the post request
    #
    # @param options [Hash] fields from fenton command line
    # @return [String] json created from the options hash
    def certificate_json(options)
      {
        certificate: {
          client: options[:client],
          project: options[:project]
        }
      }.to_json
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
