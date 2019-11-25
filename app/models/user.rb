class User < ApplicationRecord
    has_many :loadouts, dependent: :destroy
    has_many :champions, through: :loadouts
    has_many :items, through: :loadouts


    has_secure_password

    validates :username, presence: true
    validates :username, uniqueness: {message: 
    "This username has already been taken"}
    
    
end
