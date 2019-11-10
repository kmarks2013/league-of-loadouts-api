class AddLoreToChampions < ActiveRecord::Migration[6.0]
  def change
    add_column :champions, :lore, :string
  end
end
