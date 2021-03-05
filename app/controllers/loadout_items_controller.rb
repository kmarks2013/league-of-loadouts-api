class LoadoutItemsController < ApplicationController
    wrap_parameters LoadoutItem
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
        # byebug
        # Goal is to make sure a loadout item  can not be added unless there is a valid auth token and the loadout belongs to that user.
        # Loadout Item should only be added to a corresponding loadout and when the loadout belongs to the current user.
        # Loadout id should be added
        # loadout_item_params[:items_array].each do | item_id |
        #     item = Item.find(item_id.to_i)
        #     loadout_item = LoadoutItem.create(loadout_id: loadout_item_params[:loadout_id], item_id: item.id)
            
        # end
        # byebug
        loadout = Loadout.find(loadout_item_params[:loadout_id])
        # render json: loadout

        if current_user
            if loadout.user.id === current_user
                puts 'loadout belongs to user'
            else
                render json: {error: "Unauthorized Access Restricted"}, status: :unauthorized
            end
        else
            render json: {error: "You must be logged in to do this action"}, status: :unauthorized
        end
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
        params.require(:loadout_item).permit(:loadout_id, items_array: [])
    end

end
