class UsersController < ApplicationController
    before_action :current_user, only: [:update, :destroy]
    wrap_parameters :user, format: :json, include: [:password, :username, :age, :name]

    def index
        users= User.all
        render json: users.ordered_by_name
    end

    def show
        user = User.find(params[:id])
        render json: user, include: '**'
    end

    def create 
        user = User.create!(user_params)
        if user.valid?
            payload = {user_id: user.id}
            token = JWT.encode(payload, hmac_secret, 'HS256')
            render json: {user: user, token: token}, status: :created
        end
    end

    def update
        # Finding the user using the current user's id because when update fails on the current user the errors comes back as an empty object
        # this current update funciton will always find the current user and update them it doesn't error out if it tries to update the wrong user. need to fix this
        user = User.find(params[:id])
            # byebug
        if user.id == current_user.id
            user.update!(update_params)
            render json: user, include: '**', status: :accepted
        else
            render json: {error: 'Unauthorized Access Restricted'}, status: :unauthorized
        end
    end
    
    def destroy
    #    this will have the same problem as the udpate action
        user = User.find(current_user.id)
        if user.destroy!
            render json: {}
        end
    end

    private
    def user_params
        params.require(:user).permit([:name, :username, :password, :age])
    end

    def update_params
        params.require(:user).permit([:name, :username, :age])
    end

end
