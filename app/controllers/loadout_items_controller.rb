class LoadoutItemsController < ApplicationController

    def index
        loadout_items = LoadoutItem.all
        render json: loadouts_items
    end

    def show
        loadout_item = LoadoutItem.find(params[:id]) 
        render json: loadout_item
    end

    def create
        loadout_item = LoadoutItem.create(loadout_item_params)
        if loadout_item.save
            render json: loadout_item
        end
    end

    def delete
        loadout_item = LoadoutItem.find(params[:id])
        loadout_item.destroy
        loadout_items= LoadoutItem.all
        render json: loadout_items
    private

    def loadout_params
        params.permit(:loadout_id, :item_id)
    end
end
