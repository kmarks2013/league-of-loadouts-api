class LoadoutsController < ApplicationController
    wrap_parameters Loadout, include: [:user_id, :champion_id, :name]

    def index
        loadouts = Loadout.all
        render json: loadouts.ordered_by_creation
    end

    def show
        loadout = Loadout.find(params[:id]) 
        render json: loadout
    end

    def new
        loadout = Loadout.new
    end

    def create
        # Goal is to make sure a loadout can not be created unless they have the correct token
        # A loadout should only be made if there is a current user.
        # A loadout should be assigned the user id of the current user it shouldn't be passed back online.

        if current_user
            loadout = Loadout.new(loadout_params)
            if loadout && loadout.save
                render json: loadout, status: :created
            else
                render json: {errors: loadout.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render json: {error: "You must be logged in to create a loadout"}, status: :unauthorized
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
        # A loadout should only be able to be deleted if there is a current user.
        # and it should only be destroyed if it bleongs to the current user
        # byebug
        if current_user
            loadout = Loadout.find(params[:id])
            if loadout[:user_id] == current_user.id
                # byebug
                # needed to choose between rendering every loadout or rendering the current_users loadouts
                loadout.destroy
                render json: Loadout.all, status: :accepted
            else
                render json: {error: "Unauthorized Access Restricted"}
            end
        else
            render json: {error: "You must be logged in to preform this action"}
        end
    end

    private

    def loadout_params
        params.require(:loadout).permit(:champion_id, :name, :user_id)
    end
end
