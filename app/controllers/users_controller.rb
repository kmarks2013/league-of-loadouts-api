class UsersController < ApplicationController

    def show
        user = User.find(params:id)
        render json: user
    end

    def create 
        user = User.create(user_params)
        if user.valid?
            payload = {user_id: user.id}
            token = JWT.encode(payload, hmac_secrete, 'HS256')
            render json: {user: user, token: token}
        else
            render {errors: user.errors.full_messages}
        end
    end

    def update
        user = User.find(params[:id])
        if user.update(user_params)
            render json: user
        end
    end
    
    def destroy
        user = User.find(params[:id])
        user.destroy
        render json: { }
    end

    private
    def user_params
        params.permit(name, username, password, age)
    end

end
