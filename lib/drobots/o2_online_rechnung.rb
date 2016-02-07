require 'drobot'

class Drobots::O2OnlineRechnung < Drobot

  def run
    visit "https://m.o2online.de/?a=1&login=1"

    within('form[name=Login]') do
      fill_in 'IDToken1', :with => credential('username')
      fill_in 'IDToken2', :with => credential('password')
      page.save_screenshot('/tmp/screenshots/00-mein-o2.png')
      click_button 'Einloggen'
    end

    visit "https://www.o2online.de/ecare/uebersicht?10&mobile#nav-list-bill"
    click_link "Rechnung"

    within('form') do
      fill_in 'Kundenkennzahl', :with => credential('pin')
      click_link 'Abschicken'
    end

    click_link 'Rechnung'

    l = find_link "Rechnung"
    puts l[:href]
  end
end
