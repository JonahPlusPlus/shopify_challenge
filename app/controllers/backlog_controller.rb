class BacklogController < ApplicationController
  def index
    @orders = Order.all
  end
end
