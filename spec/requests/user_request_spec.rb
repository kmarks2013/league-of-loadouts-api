require 'rails_helper'

RSpec.describe "Users", type: :request do
    let(:valid_attributes) do
        {
            "username": 'afegad',
            "password": "123Ab!",
            "age": 1,
            "name": "K"
        }
    end
    let(:invalid_attributes) do
        {
            "username": '',
            "password": "abc",
            "age": "1"
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
                    User.create!(valid_attributes)
                    post users_url, params: {user: valid_attributes}
                }.to change(User, :count).by(1)
            end
        end
    end

end
