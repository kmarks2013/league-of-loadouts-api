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
        # Goal is to make sure a loadout can not be created unless they have the correct token
        loadout = Loadout.create(loadout_params)
        if loadout.valid?
            render json: loadout
        end
    end

    def update
        # Goal is to make sure a user can not be updated unless they have the correct token and it belongs the user who created it
        loadout = Loadout.find(params[:id])
        if loadout.update(loadout_params)
            render json: loadout
        end
    end

    def destroy 
        # Goal is to make sure a loadout can not be destroyed unless they have the correct token  and it belongs the user who created it
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
