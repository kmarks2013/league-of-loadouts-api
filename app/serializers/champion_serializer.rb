class ChampionSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :blurb, :lore, :title, :stats
  # has_one :stat
end
