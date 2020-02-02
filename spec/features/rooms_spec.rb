require "rails_helper"

feature "rooms", type: :feature do
  describe "rooms #show" do 
    before do 
      @room = Room.make!(name: "Test")
      visit room_path(@room.name)
    end 

    it "has a shareable link to copy", js: true do 
      current_session = Capybara.current_session
      expect(page).to have_xpath("//input[@id='copy-room-name' and 
        @value='http://#{current_session.server.host}:#{current_session.server.port}/rooms/#{@room.name}']")
      expect(page).to have_xpath("//button[@id='copy-button']", text: "Click to Copy")
    end 

    it "has a button for joining into the room" do 
      expect(page).to have_xpath("//button", text: "Join Room")
    end 

    it "has control icons for video" do 
      expect(page).to have_xpath("//i[@class='fas fa-video']")
      expect(page).to have_xpath("//i[@class='fa fa-microphone']")
      expect(page).to have_xpath("//i[@class='fa fa-phone']")
    end 

    it "redirects to home page if room is not present" do 
      visit room_path("Jyasa")
      expect(current_path).to eq root_path
      expect(page).to have_content("The room does not exist, would you like to create one?")
    end 
  end 
end