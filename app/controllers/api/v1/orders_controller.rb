class Api::V1::OrdersController < ApplicationController

    # GET /orders/
    def index
        @orders = Order.all
        render json: @orders
    end

    # GET /orders/:id
    def show
        find_order()
        if @order
            render json: @order
        else
            render json: { error: "Failed to find order" }, status: 400
        end
    end

    # POST /orders/
    def create
        @order = Order.new(order_params)
        if @order && @order.save
            render json: @order
        else
            render json: { error: "Failed to create order" }, status: 400
        end      
    end

    # PUT /orders/:id
    def update
        find_order()
        if @order && @order.update(order_params)
            render json: { message: "Successfully update order" }, status: 200
        else
            render json: { error: "Failed to update order" }, status: 400
        end
    end

    # DELETE /orders/:id
    def destroy
        find_order()
        if @order && @order.destroy
            render json: { message: "Successfully deleted order" }, status: 200
        else
            render json: { error: "Failed to delete order" }, status: 400
        end
    end
    
    private

    def order_params
        params.require(:order).permit(:customer, :destination)
    end

    def find_order
        if Order.exists?(params[:id])
            @order = Order.find(params[:id])
        else
            @order = nil
        end
    end
end
