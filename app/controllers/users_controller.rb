class UsersController < ApplicationController

    def index
        users= User.all
        render json: users.ordered_by_name
    end

    def show
        user = User.find(params[:id])
        render json: user, include: '**'
    end

    def create 
        # byebug
        user = User.create(user_params)
        if user.valid?
            payload = {user_id: user.id}
            token = JWT.encode(payload, hmac_secret, 'HS256')
            render json: {user: user, token: token}
        else
            render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def update
        # Goal is to make sure a user can not be updated unless they have the correct token
        user = User.find(params[:id])
        if user.update(user_params)
            render json: user, include: '**'
        end
    end
    
    def destroy
        # Goal is to make sure a user can not be deleted unless they have the correct token
        user = User.find(params[:id])
        user.destroy
        render json: { }
    end

    private
    def user_params
        params.permit(:name, :username, :password, :age)
    end

    # def update_params
    #     params.permit

end
