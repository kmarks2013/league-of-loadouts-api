class Item < ApplicationRecord
#   add active record scoping to order the items by name

    def self.default_order
        order('id ASC')
    end
end
