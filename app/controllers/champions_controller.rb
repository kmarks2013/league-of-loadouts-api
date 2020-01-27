class ChampionsController < ApplicationController
    def index
        champions= Champion.all
        render json: champions.default_order
        # try an order function call here to order the json by id. this could solve the api not rendering in order issue.
    end

    def show
        champion = Champion.find(params[:id])
        render json: champion
    end
end
