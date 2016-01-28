module FentonShell
  # Interfaces with the organization api on fenton server
  class Organization
    # @!attribute [r] message
    #   @return [String] success or failure message and why
    attr_accessor :message

    # Creates a new organization on fenton server by sending a post
    # request with json from the command line to create the organization
    #
    # @param global_options [Hash] global command line options
    # @param options [Hash] json fields to send to fenton server
    # @return [String] success or failure message

    def create(global_options, options)
      status, body = organization_create(global_options, options)

      if status == 201
        save_message('Organization': ['created!'])
        true
      else
        save_message(body)
        false
      end
    end

    private

    # Sends a post request with json from the command line organization
    #
    # @param global_options [Hash] global command line options
    # @param options [Hash] json fields to send to fenton server
    # @return [Fixnum] http status code
    # @return [String] message back from fenton server
    def organization_create(global_options, options)
      result = Excon.post(
        "#{global_options[:fenton_server_url]}/organizations.json",
        body: organization_json(options),
        headers: { 'Content-Type' => 'application/json' }
      )

      [result.status, JSON.parse(result.body)]
    end

    # Formulates the organization json for the post request
    #
    # @param options [Hash] fields from fenton command line
    # @return [String] json created from the options hash
    def organization_json(options)
      {
        organization: {
          name: options[:name],
          key: options[:key]
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
