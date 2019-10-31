class User < ApplicationRecord
    has_many :loadouts, dependent: :destroy
    has_many :champions, thorugh: :loadouts
    has_many :items, through: :loadouts


    has_secure_password

    validates_presence_of :username
    validates_uniqueness_of :password, :case_sensitive => false

end
