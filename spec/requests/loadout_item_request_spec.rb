require 'rails_helper'

RSpec.describe "LoadoutItems", type: :request do
# neeed 4 specific tests index, show, create destroy
    before(:each) do
        @current_user = User.first_or_create!(name: "Tester", username: "Test Username", password:"Testpass123!", age: 23 )
        @champion = Champion.first_or_create!(name: "Champion")
        @item1 = Item.first_or_create!(name: "Sword")
        @item2 = Item.first_or_create!(name: "Shield")
        @item3 = Item.first_or_create!(name: "Staff")
        @item4 = Item.first_or_create!(name: "Axe")
        @loadout = @current_user.loadouts.create!(name: "Test Loadout", champion: @champion)

    end
    let(:valid_attributes) do
        {

        }
    end
    let(:invalid_attributes) do
        {

        }
    end
    let(:valid_headers)do
        {

        }
    end

    describe "GET /index" do
        it "renders the json of all the loadout items" do
            get loadout_items_url
            expect(response).to be_successful
            expect(response.content_type).to match(a_string_including("application/json"))
        end
    end

end