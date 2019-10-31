class CreateChampions < ActiveRecord::Migration[6.0]
  def change
    create_table :champions do |t|
      t.string :name
      t.string :api_id
      t.string :image
      t.string :blurb

      t.timestamps
    end
  end
end
