require 'drobot'

class Drobots::EuservRechnung < Drobot
  def run
    visit "https://support.euserv.de/"

    find('input[name=email]').set(username)
    find('input[name=password]').set(password)
    find('select[name=form_selected_language]').set('de')

    click_button 'Login'
    click_link 'Customer Account / Invoices'
    first('form[name=billform]').find('input[name=pdfpic]').click
  end
end
