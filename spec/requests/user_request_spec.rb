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
        "age": "1",
    }
end
