require 'yaml'
require 'json-schema'
require 'credentials/passwordstore_provider'

class Runner
  SCHEMA = YAML.load_file(Drobot::BASEDIR.join('lib/runner_config_schema.yaml'))

  def initialize(config_file: nil)
    default_file = File.join(Dir.home, '.drobots.yaml')
    @config_file = config_file || default_file
    @config = YAML.load_file(@config_file)

    JSON::Validator.validate!(SCHEMA, @config)
  end

  def drobots
    @drobots ||= @config['drobots'].map do |name, config|
      credential_provider = Credentials::PasswordstoreProvider.new(pass_name: config['passwordstore']['name'])
      determine_drobot(name).new(credential_provider)
    end
  end

  def run
    drobots.each(&:run)
  end

  private

  def determine_drobot(name)
    drobot = Object.const_get("Drobots::#{name}")
    raise "#{name} doesn't inherit from Drobot" unless drobot <= Drobot
    drobot
  rescue NameError
    raise "unknown Drobot #{name}"
  end
end
