class PurchasesController < ApplicationController

  def index   
    @item_purchase = ItemPurchase.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item_purchase = ItemPurchase.new(purchase_params)
    @item = Item.find(params[:item_id]) 
    if @item_purchase.valid?
      pay_item
      @item_purchase.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def purchase_params
    params.require(:item_purchase).permit(:portal_code, 
      :prefecture_id, :city, :address, :building_name, :phone_number, :purchase_id, :item_id).merge(user_id: current_user.id,item_id: params[:item_id], token: params[:token])
  end

  def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        card: purchase_params[:token],    # カードトークン
        currency: 'jpy'
      ) 
  end
end
