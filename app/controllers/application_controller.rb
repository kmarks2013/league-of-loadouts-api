class ApplicationController < ActionController::API
    def user_payload(user)
        { user_id: user.id}
    end

    def hmac_secret
        ENV['JWT_SECRET_KEY']
    end

    def encode_token(payload)
        JWT.encode(payload, hmac_secret, 'HS256')
    end

    def current_user
        if request.headers['Authorization']
            token = request.headers["Authorization"]
            user_token = token.split(' ')[1]
            begin
                decoded_token = JWT.decode(user_token, hmac_secret, true, {algorithim: "HS256"})
                User.find(decoded_token[0]['user_id'])
            rescue
                nil
            end
        end
    end
end
