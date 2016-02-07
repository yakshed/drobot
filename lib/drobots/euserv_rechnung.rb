require 'drobot'

class Drobots::EuservRechnung < Drobot
  def run
    visit "https://support.euserv.de/"

    within('form[name=step1_anmeldung]') do
      fill_in 'email', :with => username
      fill_in 'password', :with => password
      click_button 'Login'
    end

    page.save_screenshot('/tmp/screenshots/euserv.png')
    l = find_link "Rechnung"
    puts l[:href]
    
  end
end
