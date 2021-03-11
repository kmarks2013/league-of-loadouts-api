class AuthController < ApplicationController

    def login 
        user = User.find_by(username: user_params[:username])
        if user && user.authenticate(user_params[:password])
            token = encode_token(user_payload(user))
            render json: {user: user, token: token}
        else
            render json: {errors: ['Unable to match username and password. Please try again.']} , status: :unprocessable_entity
        end
    end

    def persist
            if current_user
                render json: current_user, include: '**'
            else
                render json: {error: 'You need to be logged in to preform this action'}
            end
    end

    private
    def user_params
        params.permit(:username, :password)
    end
    
end