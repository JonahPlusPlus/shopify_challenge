class Api::V1::RequestsController < ApplicationController
    
    # GET /requests/
    def index
        @requests = Request.all
        render json: @requests
    end

    # GET /requests/:id
    def show
        find_request()
        if @request
            render json: @request
        else
            render json: { error: "Failed to find request" }, status: 400
        end
    end

    # POST /requests/
    def create
        @request = Request.new(request_params)
        if @request && @request.save
            render json: @request
        else
            render json: { error: "Failed to create request" }, status: 400
        end      
    end

    # PUT /requests/:id
    def update
        find_request()
        if @request && @request.update(request_params)
            render json: { message: "Successfully update request" }, status: 200
        else
            render json: { error: "Failed to update request" }, status: 400
        end
    end

    # DELETE /requests/:id
    def destroy
        find_request()
        if @request && @request.destroy
            render json: { message: "Successfully deleted request" }, status: 200
        else
            render json: { error: "Failed to delete request" }, status: 400
        end
    end

    private

    def request_params
        params.require(:request).permit(:order_id, :item_id, :quantity)
    end

    def find_request
        if Request.exists?(params[:id])
            @request = Request.find(params[:id])
        else
            @request = nil
        end
    end
end
