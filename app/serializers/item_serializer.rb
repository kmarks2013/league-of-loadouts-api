class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :cost, :description
end
