class LoadoutsController < ApplicationController
    before_action :current_user, only: [:create, :update, :destroy]
    wrap_parameters :loadout,format: :json, include: [:user_id, :champion_id, :name]

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
        loadout = current_user.loadouts.create(loadout_params)
        if loadout.valid?
            render json: loadout, status: :created
        else
            render json: {errors: loadout.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def update
        loadout = current_user.loadouts.find(params[:id])
        if loadout.update(loadout_update_params)
            render json: loadout, status: :accepted
        else
            render json: {errors: loadout.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy 
        loadout = current_user.loadouts.find(params[:id])
        render json: loadout

        # if current_user
        #     loadout = Loadout.find(params[:id])
        #     if loadout[:user_id] == current_user.id
        #         loadout.destroy
        #         render json: Loadout.all, status: :accepted
        #     else
        #         render json: {error: "Unauthorized Access Restricted"}
        #     end
        # else
        #     render json: {error: "You must be logged in to preform this action"}
        # end
    end

    private

    def loadout_params
        params.require(:loadout).permit([:champion_id, :name])
    end

    def loadout_update_params
        params.require(:loadout).permit(:name)
    end
end
