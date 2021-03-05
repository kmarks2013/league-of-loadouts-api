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
        auth = request.headers['Authorization']
        if auth
            token = auth.split(" ")[1]
            decoded_token = JWT.decode(token, hmac_secret, true, {algorithim: "HS256"})

            user = User.find(decoded_token[0]['user_id'])
            render json: user, include: '**'
        end
    end

    private
    def user_params
        params.permit(:username, :password)
    end
    
end