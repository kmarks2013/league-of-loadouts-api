class ItemsController < ApplicationController

    def index
        items = Item.all
        render json: items.default_order
    end

    def show
        item = Item.find(params[:id])
        render json: item
    end

end
