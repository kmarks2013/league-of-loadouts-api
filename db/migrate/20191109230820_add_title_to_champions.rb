class AddTitleToChampions < ActiveRecord::Migration[6.0]
  def change
    add_column :champions, :title, :string
  end
end
