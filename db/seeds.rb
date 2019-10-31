User.destroy_all
Champion.destroy_all
Role.destroy_all
Item.destroy_all


User.reset_pk_sequence
Champion.reset_pk_sequence
Role.reset_pk_sequence
Item.reset_pk_sequence
Loadout.reset_pk_sequence


champion_json = RestClient.get('http://ddragon.leagueoflegends.com/cdn/9.21.1/data/en_US/champion.json')
item_json = RestClient.get('http://ddragon.leagueoflegends.com/cdn/9.21.1/data/en_US/item.json')


champions_hash = JSON.parse(champion_json)['data']
items_hash = JSON.parse(item_json)['data']

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
            image: champion_info['image']['sprite'],
            api_id: champion_info['id']
        )
    # end
end

# Items

items_hash.each do |(item, item_info)|
        Item.create(
            name: item_info['name'],
            description: item_info['description'],
            cost: item_info['gold']['base'],
            tags: item_info['tags']
        )
end
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