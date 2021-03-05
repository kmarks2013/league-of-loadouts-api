require 'rails_helper'

RSpec.describe "Loadouts", type: :request do

  before(:each) do
    @current_user = User.first_or_create!(username:'testname', password:"Test1234!", name: 'test', age: 23)
    @champion = Champion.first_or_create!(name: "Champion")
    @condition = @current_user
  end

  let(:valid_attributes) do
    {
      # attributes should be user_id, champion_id, name,
      "name"=> "Test Name",
      "champion_id" =>3,
      "user_id" => User.create(username:'exmapleuser', password:'Test1234!', name: 'example', age: 23).id
    }
  end

  let(:invalid_attributes) do
    {
     "champion" => ''
    }
  end

  let(:valid_headers) {
    {"Accept": "application/json"}
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
    # context "is the current user", if: @condition do
      context "with valid attributes " do
        it "will add a loadout to the current user" do
          # loadout = @current_user.loadouts.create!(name:'test', champion:@champion)
          expect{
            post loadouts_url, params: {loadout: valid_attributes}, headers: {"ACCEPT" => "application/json"}
          }.to change(Loadout, :count).by(1)
        end

        it 'renders the json of new loadout' do
          # loadout = @current_user.loadouts.create!(valid_attributes)
          post loadouts_url, params: {loadout: valid_attributes}, headers: valid_headers, as: :json
          expect(response).to be_successful
          # expect(response.content_type).to match(a_string_including("application/json"))
          # need to return back to this test to work on getting it to pass with a conditional
          # currently this test is failing because the conditionall wil not run
      end
    end
    # end

    context "with invalid attributes" do
      it "will not add a loadout to the database" do
        # loadout = @current_user.loadouts.create!(invalid_attributes)
        expect{
          post loadouts_url, params: {loadout: invalid_attributes}, headers: valid_headers, as: :json
        }.to change(Loadout, :count).by(0)
      end  

      it 'renders json of the errors' do
        post loadouts_url, params: {loadout: invalid_attributes}, headers: valid_headers, as: :json
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    # conditional testing is causing these tests not to run. not sure why
  end

end
