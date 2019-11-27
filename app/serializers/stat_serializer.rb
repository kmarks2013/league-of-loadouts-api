class StatSerializer < ActiveModel::Serializer
  attributes :id, :hp, :hpperlevel, :mp, :mpperlevel, :movespeed, :armor, :armorperlevel, :spellblock, :spellblockperlevel, :attackrange, :hpegen, :hpregenperlevel, :mpregen, :mpregenperlevel, :crit, :critperlevel, :attackdamage, :attackdamageperlevel, :attackspeedperlevel, :attackspeed
  has_one :champion
end
