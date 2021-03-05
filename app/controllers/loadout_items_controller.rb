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
        # byebug
        if current_user
            loadout = Loadout.find(loadout_item_params[:loadout_id])
            if loadout.user.id == current_user.id
                loadout_item_params[:items_array].each do | item_id |
                    item = Item.find(item_id.to_i)
                    loadout_item = LoadoutItem.create(loadout_id: loadout_item_params[:loadout_id], item_id: item.id)
                end
                # if loadout.items.length
                    render json: loadout
                # else
                #     render json: {errors: "Items were not added" }, status: :unprocessable_entity
                # end

            else
                render json: {error: "Unauthorized Access Restricted"}, status: :unauthorized
            end
        else
            render json: {error: "You must be logged in to do this action"}, status: :unauthorized
        end
    end

    def destroy
        # Goal is to make sure a loadout item can not be deleted unless there is a valid auth token and the loadout belongs to that user.
        # conditional layers: current user, loadout ownership loadout item will find its own loadout.
        if current_user
            byebug
        else
            render json: {error: "You must be logged in to do this action"}, status: :unauthorized
        end
    end


    private

    def loadout_item_params
        params.require(:loadout_item).permit(:loadout_id, items_array: [])
    end

end
