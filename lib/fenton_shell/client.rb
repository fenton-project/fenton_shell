module FentonShell
  # Interfaces with the client api on fenton server
  class Client
    # @!attribute [r] message
    #   @return [String] success or failure message and why
    attr_accessor :message

    # Creates a new client on fenton server by sending a post
    # request with json from the command line to create the client
    #
    # @param global_options [Hash] global command line options
    # @param options [Hash] json fields to send to fenton server
    # @return [String] success or failure message

    def create(global_options, options)
      status, body = client_create(global_options, options)

      if status == 201
        save_message('Client': ['created!'])
        true
      else
        save_message(body)
        false
      end
    end

    # Calls create new client then creates an organization for that client
    # via a post request with json from the command line
    #
    # @param global_options [Hash] global command line options
    # @param options [Hash] json fields to send to fenton server
    # @return [String] success or failure message

    def create_with_organization(global_options, options)
      create(global_options, options)
      organization_options = {
        name: options[:username], key: options[:username] }

      if Organization.new.create(global_options, organization_options)
        save_message('Organization': ['created!'])
        true
      else
        save_message('Organization': ['not created!'])
        false
      end
    end

    private

    # Sends a post request with json from the command line client
    #
    # @param global_options [Hash] global command line options
    # @param options [Hash] json fields to send to fenton server
    # @return [Fixnum] http status code
    # @return [String] message back from fenton server
    def client_create(global_options, options)
      result = Excon.post(
        "#{global_options[:fenton_server_url]}/clients.json",
        body: client_json(options),
        headers: { 'Content-Type' => 'application/json' }
      )

      [result.status, JSON.parse(result.body)]
    end

    # Formulates the client json for the post request
    #
    # @param options [Hash] fields from fenton command line
    # @return [String] json created from the options hash
    def client_json(options)
      {
        client: {
          name: options[:name],
          public_key: File.read(options[:public_key])
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
