class LoadoutItemsController < ApplicationController

    def index
        loadout_items = LoadoutItem.all
        render json: loadout_items
    end

    def show
        loadout_item = LoadoutItem.find(params[:id]) 
        render json: loadout_item
    end

    def create
        # byebug
        # Goal is to make sure a loadout item  can not be added unless there is a valid auth token and the loadout belongs to that user.
        # Loadout Item should only be added to a corresponding loadout and when the loadout belongs to the current user.
        # Loadout id should be added
        loadout_item_params[:items_array].each do | item_id |
            item = Item.find(item_id.to_i)
            loadout_item = LoadoutItem.create(loadout_id: loadout_item_params[:loadout_id], item_id: item.id)
            
        end
        loadout = Loadout.find(loadout_item_params[:loadout_id])
        render json: loadout

    end

    def destroy
        # Goal is to make sure a loadout item can not be deleted unless there is a valid auth token and the loadout belongs to that user.
        loadout_item = LoadoutItem.find_by(item_id: params[:item_id], loadout_id: params[:loadout_id] )
        loadout_item.destroy
        loadout = Loadout.find(params[:loadout_id])
        render json: loadout
    end


    private

    def loadout_item_params
        params.permit(:loadout_id, items_array: [])
    end

end
