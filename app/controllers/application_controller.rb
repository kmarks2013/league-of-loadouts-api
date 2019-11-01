class ApplicationController < ActionController::API
    def hmac_secret
        ENV['JWT_SECRET_KEY']
    end
end
