class User < ApplicationRecord
    has_many :loadouts, dependent: :destroy
    has_many :champions, through: :loadouts
    has_many :items, through: :loadouts

#   add active record scoping to order the users by id, or by name




    validates :username, presence: true
    validates :username, uniqueness: {message: 
    "This username has already been taken"}
    validates :username, :length => { :in => 6..30 }
    
    PASSWORD_FORMAT = /\A
        (?=.*[A-Z])
        (?=.*[a-z])
        (?=.*\d)
        (?=.*[[:^alnum:]])
    /x
    has_secure_password
    validates :password, :length => { :minimum => 6 }
    validates :password, format: { with: PASSWORD_FORMAT, :message => 'Password must include: 1 uppercase, 1 lowercase, 1 digit and 1 special character' }

end
