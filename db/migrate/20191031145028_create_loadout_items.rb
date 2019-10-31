class CreateLoadoutItems < ActiveRecord::Migration[6.0]
  def change
    create_table :loadout_items do |t|
      t.belongs_to :loadout, null: false, foreign_key: true
      t.belongs_to :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
