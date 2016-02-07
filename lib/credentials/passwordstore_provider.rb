module Credentials
  class PasswordstoreProvider
    
    def initialize(opts)
      
      @pass_command = opts['pass_command'] || '/usr/bin/pass'
      @pass_name = opts['pass_name'] or raise ArgumentError.new("Missing pass_name for Provider")
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
