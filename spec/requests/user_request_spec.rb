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

end
