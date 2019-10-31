class CreateChampionRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :champion_roles do |t|
      t.belongs_to :champion, null: false, foreign_key: true
      t.belongs_to :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
