class Loadout < ApplicationRecord
  belongs_to :user
  belongs_to :champion
  has_many :loadout_items, dependent: :destroy
  has_many :items, through: :loadout_items

  def user_name
    self.user.username
  end

  def champion_name
    self.champion.name
  end

end
