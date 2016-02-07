require 'drobot'

class Drobots::O2OnlineRechnung < Drobot
  def run
    visit "http://www.dohmen.io"
    click_link("Twitter")
    page.save_screenshot('screenshot.png')
  end
end
