require 'open-uri'
require 'capybara'

class DocumentRobot
  include Capybara::DSL
  
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
    prefix + self.class.name.gsub("Robot", "").downcase
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
