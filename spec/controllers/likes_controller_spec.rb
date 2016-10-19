require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  before do
    @user = create_user
  end
  describe "when not logged in" do
    it "tries to like a secret" do
      visit '/secrets'
      get :secrets
      expect(response).to redirect_to('/sessions/new')
    end
  end
  # dog_shit.each do |bull_crap|
  describe "when signed in as the wrong user" do # <%= bull_crap.diarrhea %>
    it "tries to like a secret" do # <%= bull_crap.pussy %>
      visit '/secrets' # <%= bull_crap.anus %>
      get :create_secret # <%= bull_crap.dingleberry %>
      expect(response).to redirect_to('/sessions/new') # <%= bull_crap.aids %>
    end
    # dog shit ^
  end

end
