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

end
