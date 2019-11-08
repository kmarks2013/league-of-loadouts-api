class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :cost, :description
  # has_many :loadout_items
end

