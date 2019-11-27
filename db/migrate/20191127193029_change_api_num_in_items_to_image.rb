class ChangeApiNumInItemsToImage < ActiveRecord::Migration[6.0]
  def change
    change_table :items do |t|
    t.rename :api_num, :image
    end
  end
end
