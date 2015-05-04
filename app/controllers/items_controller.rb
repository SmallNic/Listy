class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @list =List.find(params[:list_id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to "/lists/#{params[:list_id]}"
    else
      render :new
    end

  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def item_params
    return params[:item].permit(:description, :list_id)
  end


end
