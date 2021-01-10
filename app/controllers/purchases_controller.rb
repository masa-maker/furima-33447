class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :move_to_index, only: :index
  before_action :sold_out_item, only: :index
  def index   
    @item_purchase = ItemPurchase.new
    
  end

  def create
    @item_purchase = ItemPurchase.new(purchase_params)
    
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

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    if current_user.id == @item.user_id
      redirect_to action: :index
    end
  end

  def sold_out_item
    redirect_to root_path if @item.purchase.present?
  end
end
