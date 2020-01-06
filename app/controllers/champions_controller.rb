class ChampionsController < ApplicationController
    def index
        champions= Champion.all
        render json: champions
    end

    def show
        champion = Champion.find(params[:id])
        render json: champion
    end
end
