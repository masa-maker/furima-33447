class PurchasesController < ApplicationController

  def index
    @item = Item.find[params[:id]]
  end

  def create
  end

  private

  def purchase_params
    params.require(:item).permit(:image, :item_name, :shipping_charge_id, :price).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
