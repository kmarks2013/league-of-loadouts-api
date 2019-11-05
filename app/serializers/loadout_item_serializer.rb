class LoadoutItemSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :loadouts
  belongs_to :items


end
