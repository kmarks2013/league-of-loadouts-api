class LoadoutsController < ApplicationController

    def index
        loadouts = Loadout.all
        render json: loadouts
    end

    def show
        loadout = Loadout.find(params[:id]) 
        render json: loadout
    end

    def create
        loadout = Loadout.create(loadout_params)
        if loadout.save
            render json: loadout
        end
    end

    def update
        loadout = Loadout.find(params[:id])
        if loadout.update(loadout_params)
            render json: loadout
        end
    end

    def destroy 
        
        loadout = Loadout.find(params[:id])
        loadout.destroy
        loadouts = Loadout.all
        render json: loadouts
    end

    private

    def loadout_params
        params.permit(:user_id, :champion_id, :name)
    end
end
