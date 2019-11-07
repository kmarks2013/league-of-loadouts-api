class LoadoutItemSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :loadout
  belongs_to :item


end
