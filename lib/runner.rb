require 'yaml'
require 'credentials/passwordstore_provider'

class Runner
  def initialize(config_file: nil)
    default_file = File.join(Dir.home, '.drobots.yaml')
    @config_file = config_file || default_file
    @config = YAML.load_file(@config_file)
  end

  def drobots
    @config['drobots'].map do |name, config|
      credential_provider = Credentials::PasswordstoreProvider.new(pass_name: config['passwordstore']['name'])
      Object.const_get("Drobots::#{name}").new(credential_provider)
    end
  end
end
