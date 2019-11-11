class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :cost, :description, :plaintext, :api_num
  # has_many :loadout_items
end

