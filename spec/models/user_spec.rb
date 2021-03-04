require 'rails_helper'

RSpec.describe User, type: :model do
    before(:each) do
        user = User.create!(name: "Testor", username: "testuser", password:'Testpass1!', age: 23)
    end

    describe 'creation' do
        it 'adds a user to the database' do
            expect(User.all.count).to eq(1)
        end
    end

    describe 'User', 'validations' do
        it {should validate_presence_of(:username)}
        it {should validate_length_of(:username).is_at_least(6).is_at_most(30)}
        it {should validate_length_of(:password).is_at_least(6)}
        it {should have_secure_password}
    end

end
