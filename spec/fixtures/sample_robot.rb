class SampleDrobot < Drobot
  
  def run
    visit "/"
    click_link 'login'

    within('#myform') do
      fill_in 'username', :with => username
      fill_in 'password', :with => password
      click_button 'Yo'
    end
    
    l = find_link 'Mega Secure Download'
    download(l[:href])
  end
end
