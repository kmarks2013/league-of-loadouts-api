# League of Loadouts

## What is League of Loadouts? 
League of Loadouts is a League of Legends companion web app that allows players to plan out a loadout for their champion of choice  a head of games.

A user can create a loadout for any champion of their choosing, and add and delete items to that loadout.

### Motivation

As an avid gamer/MOBA player I wanted to create an app that would help players like myself plan out their matchs and create based on their playstyle accordingly.


### Back-end

League of Loadouts API is built with Ruby on Rails.  For authentication, authorization and security it uses Bcrypt and JWT, and PostgresSql for its database.

### Front-end

League of Loadouts is built using React as its front end frame work and using Redux to contain majority of it's state.

Images are stored on the front end but were originally sourced through [Riot Games: League of Legends API](https://developer.riotgames.com/). 


To see more information about the front-end client please see below:
[League of Loadouts Client](https://github.com/kmarks2013/league-of-loadouts-client)

### Demo

- to be added.

### Screenshots

- to be added.


### Installation

    Clone repo and CD into the directory
    bundle install
    run rails db:create to create your postgres database
    run rails db:migrate to bring up migrationscftt5
    run rails db:seed to seed data for champions and items
    run rails s to start the server

Be sure to visit the repo for the [frontend](https://github.com/kmarks2013/league-of-loadouts-client) and follow those instructions!

### Technologies Used

1. Ruby on Rails --Api
2. Bcrypt
3. Json Web Token
4. Active Model Serializer
5. Rest-Client
6. Nokogiri
7. Active Record Reset PK Sequence 

### Special Thanks

I would like to thank [Riot Games](https://developer.riotgames.com/) for allwoing me access to their api to create this app. Without them this applicaiton would not exist. 