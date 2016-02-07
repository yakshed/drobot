class Drobots::Sample < Drobot
  def run
    visit "/"
    click_link 'login'

    within('#myform') do
      fill_in 'username', :with => credential('username')
      fill_in 'password', :with => credential('password')
      click_button 'Yo'
    end
    
    l = find_link 'Mega Secure Download'
    download(l[:href])
  end
end
