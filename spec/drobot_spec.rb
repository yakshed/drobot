require 'fileutils'
require 'pp'
require 'drobot'
require 'runner'

require_relative 'fixtures/simple_app'
require_relative 'fixtures/sample_robot'
require_relative 'fixtures/drobots/firstsample'
require_relative 'fixtures/drobots/secondsample'
require_relative 'fixtures/drobots/notinheriting'

describe "Drobot", :type => :app do
  let(:fixture_dir) { Drobot::BASEDIR.join("spec/fixtures") }
  let(:output_dir) { Drobot::BASEDIR.join("tmp") }

  describe "runner" do
    context "with valid configuration" do
      subject { Runner.new(config_file: File.join(fixture_dir, 'configs/test_config.yaml')) }

      it "iterates over multiple drobots" do
        expect(subject.drobots.count).to eq 2
        expect(subject.drobots.first).to be_a(Drobots::Firstsample)
        expect(subject.drobots.last).to be_a(Drobots::Secondsample)
      end

      it "runs Drobots" do
        subject.run
        expect(subject.drobots.first.ran?).to be true
        expect(subject.drobots.last.ran?).to be true
      end
    end
    
    context "with broken configurations" do
      it "gives a proper warning" do
        expect {
          Runner.new(config_file: File.join(fixture_dir, 'configs/broken_config.yaml'))
        }.to raise_exception(JSON::Schema::ValidationError)
      end

      it "detects non-existing Drobots" do
        expect {
          Runner.new(config_file: File.join(fixture_dir, 'configs/missing_drobot_config.yaml')).run
        }.to raise_exception(RuntimeError, /unknown Drobot NonExistingDrobot/)
      end

      it "detects non-existing Providers" do
        expect {
          Runner.new(config_file: File.join(fixture_dir, 'configs/missing_provider_config.yaml')).run
        }.to raise_exception(RuntimeError, /unknown Provider Credentials::NonexistingProvider/)
      end

      it "detects Drobots not inheriting from Drobot" do
        expect {
          Runner.new(config_file: File.join(fixture_dir, 'configs/notinheriting_config.yaml')).run
        }.to raise_exception(RuntimeError, /Notinheriting doesn't inherit from Drobot/)
      end
    end
    
  end

  describe "automated download", :type => :feature do

    let(:runner) { Runner.new }
    let(:credential_provider) { Credentials::PasswordstoreProvider.new({'pass_command' => "#{fixture_dir}/mock_pass",  'pass_name' => 'sample/app'} ) }
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
