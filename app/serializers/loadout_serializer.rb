class LoadoutSerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :user
  belongs_to :champion
  has_many :items
  has_many :loadout_items

end
