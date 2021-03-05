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
        @condition = User.find(@current_user.id).id == @current_user.id

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
            LoadoutItem.create!( loadout:@loadout, item:@item1)
            get loadout_items_url
            expect(response).to be_successful
            expect(response.content_type).to match(a_string_including("application/json"))
        end
    end

    describe "GET /show/:id" do
        before(:each)do
        @loadout_item  = LoadoutItem.create!( loadout:@loadout, item:@item1)
    end
        it 'finds the Loadout Item in the Items table' do
            @item = Item.find(@loadout_item.id)
        end

        it 'will then show the json of that item to that items show method' do
            @item = Item.find(@loadout_item.id)
            get item_url(@item.id)
            expect(response).to be_successful
            expect(response.content_type).to match(a_string_including("application/json"))
        end
    end

    describe "CREATE /create"
        context "will check that there is a logged in user" do
            it "move on to the next step if it finds one" do
                expect(@condition).to eq true
            end
        end

        context 'when there isnt a curent user' do
            it 'it will return a status of unautorhorized if not' do
                post loadout_items_url, params: {loadout:valid_attributes}, headers: valid_headers, as: :Json
                expect(response).to have_http_status :unauthorized
            end
        end

end