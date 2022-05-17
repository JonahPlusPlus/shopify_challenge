class InventoryController < ApplicationController
  def index
    @items = Item.all
    @stores = Store.all
  end

  # POST /additem
  def additem
    ActiveRecord::Base.transaction do
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
    end
    render json: { message: "Successfully updated item quantity" }
  end
end
