require 'open-uri'
require 'capybara'
class DocumentRobot
  include Capybara::DSL
  
  def initialize(target = "/tmp/foo")
    #puts "Initalized with #{target}"
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
end
