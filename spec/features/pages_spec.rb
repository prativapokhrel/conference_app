require "rails_helper"

feature "pages", type: :feature do
  it "creates a room", js: true do 
    visit "/"
    expect(Room.count).to eq 0
    fill_in "room-name", with: "Test"
    find(:xpath, "//button[@class='btn btn-blue btn-block']").click

    room = Room.last 
    expect(Room.count).to eq 1
    expect(room.name).to eq "Test"
    expect(current_path).to eq room_path(room.name) 
  end 
end 