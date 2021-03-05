require 'rails_helper'

RSpec.describe "/loadouts", type: :request do

  before(:each) do
    @current_user = User.first_or_create!(username:'testname', password:"Test1234!", name: 'test', age: 23)
    @champion = Champion.first_or_create!(name: "Champion")
    @condition = @current_user
  end

  let(:valid_attributes) do
    {
      # attributes should be user_id, champion_id, name,
      "name"=> "Test Name",
      "champion" => @champion
    }
  end

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_headers) {
    {"Accept"=> "application/json"}
  }

  describe "GET /index" do
    it "renders the json of the all the loadouts" do
      Loadout.create(name:'test', champion: @champion, user: @current_user)
      get loadouts_url
      expect(response).to be_successful
      expect(response.content_type).to match(a_string_including("application/json"))
    end
  end

  describe "GET /show/:id " do
    it "renders the json of the specfiic loadout" do
      loadout = Loadout.create(name:'test', champion: @champion, user: @current_user)
      get loadout_url(loadout), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    # context "if it is the current user", if: @condition do
      it "will add a loadout to the current user" do
        loadout = @current_user.loadouts.create!(valid_attributes)
        expect{
          post loadouts_url, params: {loadout: loadout}, headers: valid_headers, as: :json
        }.to change(Loadout, :count).by(0)
      end
    # end
  end

end
