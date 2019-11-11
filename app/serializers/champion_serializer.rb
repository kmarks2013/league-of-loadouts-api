class ChampionSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :blurb, :lore, :title
end
