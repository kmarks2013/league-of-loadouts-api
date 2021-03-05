class AuthController < ApplicationController

    def login 
        user = User.find_by(username: user_params[:username])
        # byebug
        if user && user.authenticate(user_params[:password])
            token = encode_token(user_payload(user))
            render json: {user: user, token: token}
        else
            render json: {errors: ['Unable to match username and password. Please try again.']} , status: :unprocessable_entity
        end
    end

    def persist
            if current_user
                # token = request.headers["Authorization"].split(' ')[1]
                # decoded_token = JWT.decode(token, hmac_secret, true, {algorithim: "HS256"})
                # byebug
                #  User.find(decoded_token[0]['user_id'])

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