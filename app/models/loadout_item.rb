class LoadoutItem < ApplicationRecord
  belongs_to :loadout
  belongs_to :item
end
