class Loadout < ApplicationRecord
  belongs_to :user
  belongs_to :champion
  has_many :loadout_items, dependent: :destroy
  has_many :items, through: :loadout_items

  #   add active record scoping to order the loadouts by name or creation order
  scope :ordered_by_creation, -> { order(created_at: :desc)}

  def user_name
    begin
      return self.user.username
      raise 'error'
    rescue
      puts self.name
    end
  end

  def champion_name
    self.champion.name
  end

  def user_id
    begin
      return self.user.id
      raise 'error'
    rescue
      puts self. name
    end
  end

end
