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
                # user = User.create!(valid_attributes)
                post users_url, params: {user: valid_attributes}, headers: {"ACCEPT" => "application/json"}, as: :json
                expect(response).to have_http_status(:created)
                expect(response.content_type).to match (a_string_including("application/json"))
            end
        end
    end
end
