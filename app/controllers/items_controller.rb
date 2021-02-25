class ItemsController < ApplicationController

    def index
        items = Item.all
        render json: items.ordered_by_name
    end

    def show
        item = Item.find(params[:id])
        render json: item
    end

end
