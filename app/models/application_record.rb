class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :ordered_by_name, -> {order(name: :asc)}
  scope :ordered_by_id, -> {order(id: :asc)}

end
