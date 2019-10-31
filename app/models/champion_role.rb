class ChampionRole < ApplicationRecord
  belongs_to :champion
  belongs_to :role
end
