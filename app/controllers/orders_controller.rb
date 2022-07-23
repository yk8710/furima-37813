class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @order_buyer = OrderBuyer.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order_buyer = OrderBuyer.new(order_params)
    @item = Item.find(params[:item_id])
    if @order_buyer.valid?
      @order_buyer.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_buyer).permit(:postal_code, :prefecture, :city, :block, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
