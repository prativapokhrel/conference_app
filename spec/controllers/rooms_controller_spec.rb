require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  describe "GET #show" do
    before do
      @room = Room.make!
    end

    it "should get show page" do
      get :show, params: { :id => @room.name }
      expect(response).to be_success
    end

    it "should throw 404 for bad_id" do
      get :show, params: { :id => 'bad_id' }
      expect(response).to redirect_to root_path 
      expect(flash[:error]).to be_present
    end
  end

  describe "POST #create" do 
    it "creates a room" do 
      expect{ post :create, params: { room: { name: "Jyasa" } } }.to change{Room.count}.by(1)
      expect(response).to redirect_to room_path("Jyasa")
    end 
  end  
end