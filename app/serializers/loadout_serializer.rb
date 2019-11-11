class LoadoutSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_name
  belongs_to :champion
  has_many :items

end
