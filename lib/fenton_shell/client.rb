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

    def create(global_options,options)
      client = {
        client: {
          name: options[:name],
          public_key: File.read(options[:public_key])
        }
      }

      result = Excon.post(
        "#{global_options[:fenton_server_url]}/clients.json",
        body: client.to_json,
        headers: { "Content-Type" => "application/json" }
      )

      result_body = JSON.parse(result.body)

      if result.status == 201
        save_message({'Client': ["created!"]})
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
