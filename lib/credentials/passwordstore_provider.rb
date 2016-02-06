require 'mkmf'

module Credentials
  class PasswordstoreProvider
    
    def initialize(pass_command: nil, pass_name:)
      default_command = find_executable 'pass'
      @pass_command = pass_command || default_command
      @pass_name = pass_name
    end
    
    def username
      credentials[:username]
    end
    
    def password
      credentials[:password]
    end

    private
    ##
    # Parse pass output formed like
    # 
    # soopa_secret
    # Username: my_user
    def credentials
      return @credentials if @credentials
      output = %x"#{@pass_command} #{@pass_name}".lines

      password = output.shift
      username = output.find { |line| line.start_with? 'Username:' }.split(":").pop.strip
      @credentials = {:username => username, :password => password}
    end
  end
end
