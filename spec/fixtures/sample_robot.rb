class SampleRobot < DocumentRobot
  
  def run
    visit "/"
    click_link 'login'

    within('#myform') do
      fill_in 'username', :with => 'myuser'
      fill_in 'password', :with => 'mypass'
      click_button 'Yo'
    end
    
    l = find_link 'Mega Secure Download'
    download(l[:href])
  end
end
