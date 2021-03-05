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
            loadout_id: @loadout.id,
            items_array: [@item1.id, @item2.id, @item3.id, @item4.id]
        }
    end
    let(:invalid_attributes) do
        {
            loadout_id: nil
        }
    end
    let(:valid_headers)do
        {
            "Accept": "application/json"
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

    describe "CREATE /create" do
        # attemtping to do conditional testing through nested contexts.
            context "will check that there is a logged in user" do
                it "move on to the next step if it finds one" do
                    expect(@condition).to eq true
                end

                context "it will check the ownership of hte loadout" do
                    it 'belongs to the current user' do
                        expect(@current_user.loadouts.first).to eq(@loadout)
                    end

                    context 'with valid attributes' do
                        it 'will create the new loadout items' do
                            expect{
                                post loadout_items_url, params: {loadout_item:valid_attributes}, headers: valid_headers, as: :json
                            }.to change(LoadoutItem, :count).by(valid_attributes[:items_array].length)
                        end
                        it "will return the json of the created loadout" do
                            post loadout_items_url, params: {loadout_item:valid_attributes}, headers: valid_headers, as: :json
                            expect(response).to have_http_status :created
                            expect(response.content_type).to match(a_string_including("application/json"))
                        end
                    end

                    context 'with invalid attributes' do
                        it 'will not create the new loadout itmes' do
                            expect{
                                post loadout_items_url, params: {loadout_item:invalid_attributes}, headers: valid_headers, as: :json
                            }.to change(LoadoutItem, :count).by(0)
                        end
                        it "will return the json of the created loadout" do
                            post loadout_items_url, params: {loadout_item:invalid_attributes}, headers: valid_headers, as: :json
                            expect(response).to have_http_status :created
                            expect(response.content_type).to match(a_string_including("application/json"))
                        end
                    end

                    context 'it does not belong to the current user' do
                        it "returns with an unauthorized status" do
                            post loadout_items_url, params: {loadout_item:valid_attributes}, headers: valid_headers, as: :json
                            expect(response).to have_http_status :unauthorized
                        end
                    end
                end

            end

            context 'when there isnt a curent user' do
                it 'it will return a status of unautorhorized if not' do
                    post loadout_items_url, params: {loadout_item:valid_attributes}, headers: valid_headers, as: :Json
                    expect(response).to have_http_status :unauthorized
                end
            end
    end

end