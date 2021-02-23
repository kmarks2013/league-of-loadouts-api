class Item < ApplicationRecord
#   add active record scoping to order the items by name
    # scope :ordered_by_name, -> {order(name: :asc)}


    def self.default_order
        order('id ASC')
    end
end
