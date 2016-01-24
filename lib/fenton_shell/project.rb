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

    def create(global_options,options)
      project = {
        project: {
          name: options[:name],
          description: options[:description],
          passphrase: options[:passphrase]
        }
      }

      result = Excon.post(
        "#{global_options[:fenton_server_url]}/projects.json",
        body: project.to_json,
        headers: { "Content-Type" => "application/json" }
      )

      result_body = JSON.parse(result.body)

      if result.status == 201
        save_message({'Project': ["created!"]})
        true
      else
        save_message(result_body)
        false
      end
    end

    private

    # Helps output the error message from fenton server
    #
    # @param msg [Hash] fields from fenton public classes
    # @return [String] changed hash fields to string for command line output
    def save_message(msg={})
      self.message ||= ""

      msg.each do |key,value|
        self.message << "#{key.capitalize} #{value.first}\n"
      end
    end
  end
end
