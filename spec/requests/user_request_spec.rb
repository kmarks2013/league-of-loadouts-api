require 'rails_helper'

RSpec.describe "Users", type: :request do
    let(:valid_attributes) {
        "username": 'afegad',
        "password": "123Ab!",
        "age": 1,
        "name": "K"
    }
    let(:invalid_attributes){
        "username": '',
        "password": "abc",
        "age": "1"
    }

    describe "GET /index" do
        it 'renders the list of users' do
            User.create!(valid_attributes)
            get users_url
            expect(response).to be_successful
        end
    end

    describe "GET /show" do
        context 'with out current user' do
            it 'renders a specific user or the current user' do
                user = User.create!(valid_attributes)
                get user_url(user)
                expect(response).to be_successful
            end
        end
    end
end
