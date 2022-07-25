class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @order_buyer = OrderBuyer.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order_buyer = OrderBuyer.new(order_params)
    @item = Item.find(params[:item_id])
    @item.price = Item.find(params[:item_id]).price
    if @order_buyer.valid?
      pay_item
      @order_buyer.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_buyer).permit(:postal_code, :prefecture, :city, :block, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
