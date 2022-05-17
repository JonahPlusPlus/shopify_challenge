class Api::V1::StoresController < ApplicationController
    # GET /stores/
    def index
        @stores = Store.all
        render json: @stores
    end

    # GET /stores/:id
    def show
        find_store()
        if @store
            render json: @store
        else
            render json: { error: "Failed to find store" }, status: 400
        end
    end

    # POST /stores/
    def create
        @store = Store.new(store_params)
        if @store && @store.save
            render json: @store
        else
            render json: { error: "Failed to create store" }, status: 400
        end
    end

    # PUT /stores/:id
    def update
        find_store()
        if @store && @store.update(store_params)
            render json: { message: "Successfully update store" }, status: 200
        else
            render json: { error: "Failed to update store" }, status: 400
        end
    end

    # DELETE /stores/:id
    def destroy
        find_store()
        if @store && @store.destroy
            render json: { message: "Successfully deleted store" }, status: 200
        else
            render json: { error: "Failed to delete store" }, status: 400
        end
    end

    private

    def store_params
        params.require(:store).permit(:item_id, :quantity)
    end

    def find_store
        if Store.exists?(params[:id])
            @store = Store.find(params[:id])
        else
            @store = nil
        end
    end
end
