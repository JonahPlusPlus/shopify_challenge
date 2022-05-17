class Api::V1::ItemsController < ApplicationController

    # GET /items/
    def index
        @items = Item.all
        render json: @items
    end

    # GET /items/:id
    def show
        find_item()
        if @item
            render json: @item
        else
            render json: { error: "Failed to find item" }, status: 400
        end
    end

    # POST /items/
    def create
        @item = Item.new(item_params)
        if @item && @item.save
            render json: @item
        else
            render json: { error: "Failed to create item" }, status: 400
        end      
    end

    # PUT /items/:id
    def update
        find_item()
        if @item && @item.update(item_params)
            render json: { message: "Successfully update item" }, status: 200
        else
            render json: { error: "Failed to update item" }, status: 400
        end
    end

    # DELETE /items/:id
    def destroy
        find_item()
        if @item && @item.destroy
            render json: { message: "Successfully deleted item" }, status: 200
        else
            render json: { error: "Failed to delete item" }, status: 400
        end
    end

    private

    def item_params
        params.require(:item).permit(:name)
    end

    def find_item
        if Item.exists?(params[:id])
            @item = Item.find(params[:id])
        else
            @item = nil
        end
    end
end
