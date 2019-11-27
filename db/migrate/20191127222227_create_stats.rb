class CreateStats < ActiveRecord::Migration[6.0]
  def change
    create_table :stats do |t|
      t.belongs_to :champion, null: false, foreign_key: true
      t.integer :hp
      t.integer :hpperlevel
      t.integer :mp
      t.integer :mpperlevel
      t.integer :movespeed
      t.integer :armor
      t.integer :armorperlevel
      t.integer :spellblock
      t.integer :spellblockperlevel
      t.integer :attackrange
      t.integer :hpegen
      t.integer :hpregenperlevel
      t.integer :mpregen
      t.integer :mpregenperlevel
      t.integer :crit
      t.integer :critperlevel
      t.integer :attackdamage
      t.integer :attackdamageperlevel
      t.integer :attackspeedperlevel
      t.integer :attackspeed

      t.timestamps
    end
  end
end
