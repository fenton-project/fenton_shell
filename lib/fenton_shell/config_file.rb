module FentonShell
  # Provides a local configuration file
  class ConfigFile
    # @!attribute [r] message
    #   @return [String] success or failure message and why
    attr_accessor :message

    # Creates a configuration file on the local file system
    #
    # @param global_options [Hash] global command line options
    # @param options [Hash] fields to send to create the configuration file
    # @return [String] success or failure message

    def create(global_options, options)
      status, body = config_file_create(global_options, options)

      if status
        save_message('ConfigFile': ['created!'])
        true
      else
        save_message(body)
        false
      end
    end

    # Responds with the default organization
    #
    # @param global_options [Hash] global command line options
    # @return [String] default organization key for client
    def self.default_organization(_global_options)
      config_file['default_organization']
    end

    private

    # Loads the configuration file content
    #
    # @param global_options [Hash] global command line options
    # @return [Hash] content from yaml config file
    def config_file(global_options)
      YAML.load_file("#{global_options[:directory]}/config")
    end

    # Creates the configuration file
    #
    # @param options [Hash] fields from fenton command line
    # @return [Object] true or false
    # @return [String] message on success or failure
    def config_file_create(global_options, options)
      config_directory_create(global_options)

      file = "#{global_options[:directory]}/config"
      content = config_generation(file, options)
      File.write(file, content)

      [true, 'ConfigFile': ['created!']]
    end

    # Generates the configuration file content
    #
    # @param options [Hash] fields from fenton command line
    # @return [String] true or false
    def config_generation(file, options)
      config_contents = File.exist?(file) ? YAML.load_file(file) : {}

      config_options = options.keys.map(&:to_sym).sort.uniq
      config_options.delete(:password)
      config_options.each do |config_option|
        config_contents.store(config_option.to_s, options[config_option])
      end

      config_contents.store('default_organization', options[:username])

      config_contents.to_yaml
    end

    def config_directory_create(global_options)
      FileUtils.mkdir_p(global_options[:directory])
    rescue Errno::EEXIST => e
      if e.message =~ %r{File exists}
        save_message('ConfigFile': ['creation failed, a file ' \
          'exists in that path'])
        return
      end

      raise e.message
    end

    # Helps output the error message from the class
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
