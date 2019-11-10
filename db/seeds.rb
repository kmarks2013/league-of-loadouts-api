User.destroy_all
Champion.destroy_all
Role.destroy_all
Item.destroy_all
Loadout.destroy_all
LoadoutItem.destroy_all


User.reset_pk_sequence
Champion.reset_pk_sequence
Role.reset_pk_sequence
Item.reset_pk_sequence
Loadout.reset_pk_sequence
LoadoutItem.reset_pk_sequence

url = 
champions_json = RestClient.get('http://ddragon.leagueoflegends.com/cdn/9.21.1/data/en_US/champion.json')
items_json = RestClient.get('http://ddragon.leagueoflegends.com/cdn/9.21.1/data/en_US/item.json')


champions_hash = JSON.parse(champions_json)['data']
items_hash = JSON.parse(items_json)['data']

# Users
kenny = User.create(name:"Kenny", password:'1234', username:'kmarks2013', age:31)
kim = User.create(name:"Kimberly", password:'1', username:'bones', age:22)
avi = User.create(name:"Avi", password:'1', username:'ivanister', age:25)
matt = User.create(name:"Matt", password:'1', username:'matt', age:27)

# Champions

champions_hash.each do |(champion, champion_info)|
    # byebug
    # if !Champion.where(api_id: champion[champion_info['id']]).exists? 
    Champion.create(
        name: champion_info['name'],
        blurb: champion_info['blurb'],
        image: champion_info['image']['full'],
        api_id: champion_info['id'],
        title: champion_info['title']
    )
    # end
end

Champion.all.each do |champion|
    url = 'http://ddragon.leagueoflegends.com/cdn/9.22.1/data/en_US/champion/'
    name = champion.api_id
    champion_json = RestClient.get(url + name + '.json')
    champion_data = JSON.parse(champion_json)['data']
    champion_info = champion_data[name]
    champion.update(
        lore: champion_info['lore']
    )
end

# Loadouts


# testA = Loadout.create(user:kenny, champion: champion.first, name: 'test build')
# testB = Loadout.create(user:kenny, champion: champion.second, name: 'test build 2')
# testC = Loadout.create(user:kim, champion: champion.first, name: 'test build 3')
# testD = Loadout.create(user:kim, champion: champion.third, name: 'test build 4')

# Items

items_hash.each do |(item, item_info)|
        Item.create(
            name: item_info['name'],
            description: (Nokogiri::HTML(item_info['description']).content.split('<br>').join('')),
            cost: item_info['gold']['base'],
            tags: item_info['tags'],
            plaintext: item_info['plaintext']
        )
end

nums = items_hash.keys

Item.all.each do |item|
    item.update(
        api_num: nums[0]
    )
    nums.shift
end

# # LoadoutItems
# item1 = LoadoutItem.create(loadout:testA, item: item.first)
# item2 = LoadoutItem.create(loadout:testA, item: item.second)
# item3 = LoadoutItem.create(loadout:testA, item: item.third)
# item4 = LoadoutItem.create(loadout:testA, item: item.fourth)
# item5 = LoadoutItem.create(loadout:testB, item: item.first)
# item6 = LoadoutItem.create(loadout:testB, item: item.second)



# Roles
fighter = Role.create(name:"fighter")
tank = Role.create(name:"tank")
mage = Role.create(name:"mage")
assassin = Role.create(name:"assassin")
support = Role.create(name:"support")
marksman = Role.create(name:"marksman")


# stats (chamion 'http://ddragon.leagueoflegends.com/cdn/9.21.1/data/en_US/champion.json')
# )

puts "We are the Champions!"