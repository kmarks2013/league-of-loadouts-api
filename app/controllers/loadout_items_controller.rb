class LoadoutItemsController < ApplicationController
    before_action :current_user, only: [:create, :destroy]
    wrap_parameters :loadout_item, format: :json, include: [:loadout_id, :items_array]

    def index
        loadout_items = LoadoutItem.all
        render json: loadout_items
    end

    def show
        loadout_item = LoadoutItem.find(params[:id])
        item = Item.find(loadout_item.id)
        render json: item
    end

    def create
        # future update nest this to be under the loadout
        loadout = current_user.loadouts.find(loadout_item_params[:loadout_id])
        if create_loadout_items(loadout, loadout_item_params[:items_array])
            render json: loadout
        else
            render json: {error: loadout_items.errors.full_messages}
        end
    end

    def destroy
        loadout_item = current_user.loadout_items.find(params[:id])
        loadout = current_user.loadouts.find(loadout_item.loadout_id)
        if loadout_item.destroy!
            render json: loadout
        end
    end


    private

    def loadout_item_params
        params.require(:loadout_item).permit([:loadout_id, items_array: []])
    end

    def create_loadout_items(loadout, items)
        items.each do | item |
            loadout.loadout_items.create(item_id: item)
        end
    end

end
