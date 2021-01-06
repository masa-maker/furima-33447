class ItemsController < ApplicationController
before_action :move_to_index, only: :new

  def index
  end

  def new
  end

  def create
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :info, :price, :category_id, :item_status_id, :shipping_charge_id, :prefecture_id, :shipping_date_id, :image).merge(user_id: current_user.id)
  end

  def move_to_index 
    unless user_signed_in?
      redirect_to user_session_path
    end
  end
end
