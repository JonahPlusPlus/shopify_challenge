class RootController < ApplicationController
  def index
    @items = Item.all
  end

  # POST /api/v1/checkout
  # Creates an order and related requests
  # Fails when there aren't any requests, out of stock, or bad API request
  def checkout
    ActiveRecord::Base.transaction do
      if (params[:customer].length < 1 || params[:destination].length < 1)
        render json: { error: "Need proper customer and destination" }, status: 400
        raise ActiveRecord::Rollback
        return
      end
      order = Order.create(customer: params[:customer], destination: params[:destination])
      if (JSON.parse(params[:requests]).length < 1)
        render json: { error: "Need items for order" }, status: 400
        raise ActiveRecord::Rollback
        return
      end
      for tup in JSON.parse(params[:requests]).each
        item = Item.find_by(name: tup[0])
        if (!!item)
          store = Store.find_by(item_id: item.id)
          if (!!store)
            logger.debug(store.quantity)
            if (store.quantity.to_i >= tup[1].to_i)
              Request.create(order_id: order.id, item_id: item.id, quantity: tup[1].to_i)
              Store.update(store.id, quantity: store.quantity - tup[1].to_i)
            else
              render json: { error: "Failed to find enough of an item" }, status: 400
              raise ActiveRecord::Rollback
              return
            end
          else
            render json: { error: "Failed to find any of an item" }, status: 400
            raise ActiveRecord::Rollback
            return
          end
        else
          render json: { error: "Failed to find item" }, status: 400
          raise ActiveRecord::Rollback
          return
        end
      end
      render json: { success: "Successfully created order" }
    end
  end
end
