class ChampionRolesController < ApplicationController
    
    def create
        User.create()
    end
end
