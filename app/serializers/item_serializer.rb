class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :cost, :description, :plaintext, :image
  # has_many :loadout_items
end

