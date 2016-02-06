require 'open-uri'
require 'capybara'
require 'version'
require 'drobots'

class Drobot
  include Capybara::DSL

  # Optimized for Programmer Happyness
  BASEDIR = Pathname.new(__dir__).parent
  
  def initialize(credential_provider, target = "/tmp/foo")
    @credential_provider = credential_provider
    @target = target
  end
  
  def download(url)
    open("#{@target}/#{title}.pdf", 'wb') do |file|
      # puts "Downloading #{url}"
      file << open(url).read
    end
  end

  def title
    drobot_name = self.class.name.split("::").pop
    prefix + drobot_name.downcase
  end
  
  def prefix
    Date.today.strftime("%Y-%m-")
  end

  def username
    @credential_provider.username
  end

  def password
    @credential_provider.password
  end
end
