class InventoryController < ApplicationController
  def index
    @items = Item.all
    @stores = Store.all
  end

  # POST api/v1/additem
  # Create item in items if it doesn't exist, and adds quantity to item's Store
  # Fails if quantity is not positive or no name is passed
  def additem
    ActiveRecord::Base.transaction do
      unless (params.has_key?(:name) && params.has_key?(:quantity))
        render json: { error: "Need params" }, status: 400
        raise ActiveRecord::Rollback
        return
      end
      if params[:name].length < 1 || params[:quantity].to_i < 1
        render json: { error: "Failed to update item quantity" }, status: 400
        raise ActiveRecord::Rollback
        return
      end
      @item = Item.find_by(name: params[:name])
      unless !!@item
        @item = Item.create(name: params[:name])
      end
      @store = Store.find_by(item_id: @item.id)
      unless !!@store
        @store = Store.create(item_id: @item.id, quantity: params[:quantity].to_i)
      else
        Store.update(@store.id, quantity: @store.quantity + params[:quantity].to_i)
      end
      render json: { message: "Successfully updated item quantity" }
    end
  end
end
