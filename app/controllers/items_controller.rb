class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit]
  before_action :move_to_index, only: :edit

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
   if @item.valid?
    redirect_to item_path(@item.id)
   else
    render 'edit'
   end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :info, :price, :category_id, :item_status_id, :shipping_charge_id, :prefecture_id,
                                 :shipping_date_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    if user_signed_in? && current_user.id != @item.user.id
      redirect_to action: :index
    end
  end
end
