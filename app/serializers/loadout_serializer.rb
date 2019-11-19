class LoadoutSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_name, :user_id
  belongs_to :champion
  # belongs_to :user
  has_many :items

end
