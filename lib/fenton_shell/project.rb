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
        save_message('Project': ['created!'])
        true
      else
        save_message(body)
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
          passphrase: options[:passphrase]
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
