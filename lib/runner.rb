require 'yaml'
require 'json-schema'
require 'credentials/passwordstore_provider'




class Runner
  SCHEMA = {
    "type" => "object",
    "required" => ["drobots"],
    "properties" => {
      "drobots" => {
        "type" => "object",
        "patternProperties" => {
          ".+" => {
            "type"  => "object",
            "properties" => {
              "passwordstore" => {
                "type" => "object",
                "properties" => {
                  "name" => {
                    "type" => "string"
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  def initialize(config_file: nil)
    default_file = File.join(Dir.home, '.drobots.yaml')
    @config_file = config_file || default_file
    @config = YAML.load_file(@config_file)

    JSON::Validator.validate!(SCHEMA, @config)
  end

  def drobots
    @drobots ||= @config['drobots'].map do |name, config|
      credential_provider = Credentials::PasswordstoreProvider.new(pass_name: config['passwordstore']['name'])
      Object.const_get("Drobots::#{name}").new(credential_provider)
    end
  end

  def run
    drobots.each(&:run)
  end
end
