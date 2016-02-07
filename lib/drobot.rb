require 'open-uri'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'pathname'



require 'credentials/passwordstore_provider'
require 'credentials/static_provider'

Capybara.default_driver = :poltergeist
Capybara.default_max_wait_time = 120
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {
                                      :debug => false,
                                      :js_errors => false,
                                      :timeout => 200
                                    })
end

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

  def credential(name)
    @credential_provider.send(name)
  end
end

require 'drobots'
require 'runner'
require 'version'
