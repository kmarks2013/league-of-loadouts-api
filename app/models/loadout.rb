class Loadout < ApplicationRecord
  belongs_to :user
  belongs_to :champion
  has_many :loadout_items, dependent: :destroy
  has_many :items, through: :loadout_items

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
