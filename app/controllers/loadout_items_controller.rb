class LoadoutItemsController < ApplicationController
    before_action :current_user, only: [:create, :destroy]
    wrap_parameters :loadout_item, format: :json

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
        byebug
        # if current_user
        #     loadout = Loadout.find(loadout_item_params[:loadout_id])
        #     if loadout.user.id == current_user.id
        #         loadout_item_params[:items_array].each do | item_id |
        #             item = Item.find(item_id.to_i)
        #             loadout_item = LoadoutItem.create(loadout_id: loadout_item_params[:loadout_id], item_id: item.id)
        #         end
        #             render json: loadout
        #     else
        #         render json: {error: "Unauthorized Access Restricted"}, status: :unauthorized
        #     end
        # else
        #     render json: {error: "You must be logged in to do this action"}, status: :unauthorized
        # end
    end

    def destroy
        # if current_user
        #     loadout_item = LoadoutItem.find(params[:id])
        #     loadout = Loadout.find(loadout_item.loadout_id)
        #     if loadout.user.id == current_user.id
        #         loadout_item.destroy
        #         render json: loadout
        #     else
        #         render json: {error: "Unauthorized Access Restricted"}, status: :unauthorized
        #     end
        # else
        #     render json: {error: "You must be logged in to do this action"}, status: :unauthorized
        # end
    end


    private

    def loadout_item_params
        params.require(:loadout_item).permit(:loadout_id, items_array: [])
    end

end
