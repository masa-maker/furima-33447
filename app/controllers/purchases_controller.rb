class PurchasesController < ApplicationController

  def index   
    @item_purchase = ItemPurchase.new
    @item = Item.find(params[:item_id])
  end

  def create
    
  end

  private

  def purchase_params
    params.require(:item_purchase).permit(:token, :portal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :purchase)
  end
end
