require 'document_robot'
require 'fileutils'
require_relative 'fixtures/simple_app'
require_relative 'fixtures/sample_robot'
  
#Capybara.default_driver = :rack_test

describe "A simple app", :type => :feature do

  let(:dir) { dir = "#{File.dirname(__FILE__)}/fixtures/output" }
  subject { SampleRobot.new(dir) }

  before :each do
    Capybara.app = SimpleApp.new
    FileUtils.mkdir_p(dir)
  end

  it "has a login" do
    subject.run
    #@robot.download(l[:href])
  end
  
  it "has downloadable files" do
    files = proc { Dir["#{dir}/**"] }
    FileUtils.rm(files.call)
    
    expect(files.call).to eq []
    
    subject.run

    filename = Date.today.strftime("%Y-%m-sample.pdf")
    expect(files.call).to eq [ File.join(dir, filename) ]
  end
  
  #within("#session") do
  #  fill_in 'Email', :with => 'user@example.com'
  #  fill_in 'Password', :with => 'password'
  #end

  #l = find_link 'eins'
  #puts l[:href]
  #open('/tmp/out.pdf', 'wb') do |file|
  #  file << open(l[:href]).read
  #  puts ("Downloading...")
  #end

end
