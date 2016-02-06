require 'drobot'
require 'fileutils'

require 'credentials/passwordstore_provider'

require_relative 'fixtures/simple_app'
require_relative 'fixtures/sample_robot'
  
#Capybara.default_driver = :rack_test

describe "A simple app", :type => :feature do

  let(:fixture_dir) { "#{File.dirname(__FILE__)}/fixtures" }
  let(:output_dir) { "#{fixture_dir}/output" }

  let(:credential_provider) { Credentials::PasswordstoreProvider.new(pass_command: "#{fixture_dir}/mock_pass",  pass_name: 'sample/app') }
  
  subject { SampleDrobot.new(credential_provider, output_dir) }

  before do
    Capybara.app = SimpleApp.new
    FileUtils.mkdir_p(output_dir)
  end
  
  it "has downloadable files" do
    files = proc { Dir["#{output_dir}/**"] }
    FileUtils.rm(files.call)
    
    expect(files.call).to eq []
    
    subject.run

    filename = Date.today.strftime("%Y-%m-sampledrobot.pdf")
    expect(files.call).to eq [ File.join(output_dir, filename) ]
  end
end
