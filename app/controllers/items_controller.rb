class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit,:update]
  before_action :authenticate_user!, except: [:show, :index]
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
   if @item.update(item_params)
    redirect_to item_path(@item.id)
   else
    render 'edit'
   end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to action: :index
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
    if current_user.id != @item.user_id
      redirect_to action: :index
    end
  end
end
