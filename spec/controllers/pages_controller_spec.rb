require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET #home" do
    it "get home page" do
      get :home
      expect(response).to be_success
    end
  end
end