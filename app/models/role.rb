class Role < ApplicationRecord
    has_many :champion_roles
    has_many :champions, through: :champion_roles
    has_many :users, through
end
