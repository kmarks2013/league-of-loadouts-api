class CreateStats < ActiveRecord::Migration[6.0]
  def change
    create_table :stats do |t|
      t.belongs_to :champion, null: false, foreign_key: true
      t.float :hp
      t.float :hpperlevel
      t.float :mp
      t.float :mpperlevel
      t.float :movespeed
      t.float :armor
      t.float :armorperlevel
      t.float :spellblock
      t.float :spellblockperlevel
      t.float :attackrange
      t.float :hpregen
      t.float :hpregenperlevel
      t.float :mpregen
      t.float :mpregenperlevel
      t.float :crit
      t.float :critperlevel
      t.float :attackdamage
      t.float :attackdamageperlevel
      t.float :attackspeedperlevel
      t.float :attackspeed

      t.timestamps
    end
  end
end
