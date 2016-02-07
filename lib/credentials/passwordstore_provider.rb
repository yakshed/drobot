module Credentials
  class PasswordstoreProvider
    
    def initialize(opts)
      
      @command = opts['command'] || '/usr/bin/pass'
      @name = opts['name'] or raise ArgumentError.new("Missing name for Provider")
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
      output = %x"#{@command} #{@name}".lines

      password = output.shift
      username = output.find { |line| line.start_with? 'Username:' }.split(":").pop.strip
      @credentials = {:username => username, :password => password}
    end
  end
end
