class Loadout < ApplicationRecord
  belongs_to :user
  belongs_to :champion
  has_many :loadout_items, dependent: :destroy
  has_many :items, through: :loadout_items
end
