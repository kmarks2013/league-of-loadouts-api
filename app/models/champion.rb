class Champion < ApplicationRecord
    has_many :loadouts
    has_many :users, through: :loadouts
    has_many :champion_roles
    has_many :roles, through: :champion_roles
    has_many :items, through: :loadouts
    has_one :stat

#   add active record scoping to order the champions by name
    # scope :ordered_by_name, -> {order(name: :asc)}

    def stats
        self.stat
    end

    def self.default_order
        order('id ASC')
    end

end
