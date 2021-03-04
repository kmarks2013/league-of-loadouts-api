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
        user = User.create(user_params)
        if user.valid?
            payload = {user_id: user.id}
            token = JWT.encode(payload, hmac_secret, 'HS256')
            render json: {user: user, token: token}, status: :created
        else
            render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def update
        # Finding the user using the current user's id because when my update fails on the current user the errors comes back as an empty object
        # Next step will be to implement a begin rescue call currently it isn't hitting any errors.

        user = User.find(current_user.id)
        unless !!user.update(update_params)
            render json: {errors: exception.message}, status: :unprocessable_entity
        end

        render json: user, include: '**', status: :accepted

        # begin
        #     user.update(update_params)
        #     render json: user, include: '**', status: :accepted
        # rescue StandardError => exception
        #     render json: {errors: exception.message}, status: :unprocessable_entity
        # end

        # user = User.find(current_user.id)
        # if user.update(update_params)
        #     render json: user, include: '**', status: :accepted
        # else
        #     render json: {errors: user.errors.full_messages}
        # end
    end
    
    def destroy
        user = User.find(params[:id])
        if user == current_user
            user.destroy
            render json: { }
        else
            render json: {error: "Unauthorized Access Restricted"}, status: :unauthorized
        end
    end

    private
    def user_params
        params.require(:user).permit([:name, :username, :password, :age])
    end

    def update_params
        params.require(:user).permit(:name, :username, :password, :age)
    end

end
