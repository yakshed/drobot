require 'fileutils'
require 'pp'
require 'drobot'
require 'runner'
require 'credentials/passwordstore_provider'

require_relative 'fixtures/simple_app'
require_relative 'fixtures/sample_robot'

require_relative 'fixtures/drobots/firstsample'
require_relative 'fixtures/drobots/secondsample'

  
describe "Drobot", :type => :app do
  let(:fixture_dir) { "#{File.dirname(__FILE__)}/fixtures" }
  let(:output_dir) { "#{fixture_dir}/output" }

  describe "runner" do
    subject { Runner.new(config_file: File.join(fixture_dir, 'test_config.yaml')) }

    it "iterates over multiple drobots" do
      drobots = subject.drobots
      expect(drobots.count).to eq 2
      expect(drobots.first).to be_a(Drobots::Firstsample)
      expect(drobots.last).to be_a(Drobots::Secondsample)
    end

    it "runs Drobots" do
      subject.run
      
      expect(subject.drobots.first.ran?).to be true
      expect(subject.drobots.last.ran?).to be true
    end
  end

  describe "automated download", :type => :feature do

    let(:runner) { Runner.new }
    let(:credential_provider) { Credentials::PasswordstoreProvider.new(pass_command: "#{fixture_dir}/mock_pass",  pass_name: 'sample/app') }
    subject { Drobots::Sample.new(credential_provider, output_dir) }

    before do
      Capybara.app = SimpleApp.new
      FileUtils.mkdir_p(output_dir)
    end
    
    it "sorts files into the correct folder." do
      files = proc { Dir["#{output_dir}/**"] }
      FileUtils.rm(files.call)
      
      expect(files.call).to eq []
      
      subject.run

      filename = Date.today.strftime("%Y-%m-sample.pdf")
      expect(files.call).to eq [ File.join(output_dir, filename) ]
    end
  end
end
