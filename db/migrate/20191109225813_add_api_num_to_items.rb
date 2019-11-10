class AddApiNumToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :api_num, :string
  end
end
