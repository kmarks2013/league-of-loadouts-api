require 'rails_helper'

RSpec.describe "Users", type: :request do
    let(:valid_attributes) do
        {
            "name" => "Testor",
            "username" => 'testUser',
            "password" => "Testpass1!",
            "age" => 35
        }
    end
    let(:invalid_attributes) do
        {
            "username" => '',
            "password" => "abc",
        }
    end

    let(:valid_headers) do
        {
            "Accept": 'application/json'
        }
    end

    describe "GET /index" do
        it 'renders the list of users' do
            User.create!(valid_attributes)
            get users_url
            expect(response).to be_successful
        end
    end

    describe "GET /show" do
        it 'renders a specific user' do
            user = User.create!(valid_attributes)
            get user_url(user)
            expect(response).to be_successful
        end
    end

    describe "POST /create" do
        context 'with valid paramters' do
            it 'creates a new User' do
                expect {
                    post users_url, params: {user: valid_attributes}, headers: {"ACCEPT" => "application/json"}
                }.to change(User, :count).by(1)
            end

            it 'renders the JSON response with a new User' do
                post users_url, params: {user: valid_attributes}, headers: {"ACCEPT" => "application/json"}, as: :json
                expect(response).to have_http_status(:created)
                expect(response.content_type).to match (a_string_including("application/json"))
            end
        end

        context 'with invalid paramaters' do
            it 'does not create a new User' do
                expect {
                    post users_url, params: {user: invalid_attributes}
                }.to change(User, :count).by(0)
            end

            it 'does not render a JSON response with a new User' do
                post users_url, params: {user: invalid_attributes}, headers: {"ACCEPT" => "application/json" , "CONTENT-TYPE" => "application/json"}, as: :json
                expect(response).to have_http_status :unprocessable_entity
                expect(response.content_type).to match (a_string_including("application/json"))
            end
        end

        context 'with duplicate usernames' do
            it "it won't save the duplicate User" do
                User.create!(valid_attributes)
                post users_url, params: {user: invalid_attributes}, headers: {"ACCEPT" => "application/json" , "CONTENT-TYPE" => "application/json"}, as: :json
                expect(response).to have_http_status :unprocessable_entity
                expect(response.content_type).to match (a_string_including("application/json"))
            end
        end
    end

    describe "PATCH /update " do
        context 'with valid parameters' do
            before(:each) do
                @current_user = User.create!(valid_attributes)
                @condition = User.find(@current_user.id).id == @current_user.id
            end
            let(:new_attributes) do
                {
                    "name" => "New name",
                    "age" => '27',
                    "username" => "newTestUsername"
                }
            end
            context" it will check that the current user is the user to be updated", if: @condition do
                it "will check that the Curent User is the user to be updated" do
                    user = User.find(@current_user.id)
                    expect(user).to eq(@current_user)
                end
                it 'will then update the requested user' do
                    user = User.find(@current_user.id)
                    patch user_url(user), params: {user: new_attributes}, headers: valid_headers, as: :json
                    user.reload
                end
                it 'renders the JSON response with the updated user' do
                    user = User.find(@current_user.id)
                    patch user_url(user), params: {user: new_attributes}, headers: valid_headers, as: :json
                    expect(response).to have_http_status :accepted
                end
            end
        end
    end
end
