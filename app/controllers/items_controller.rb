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
    @list = List.find(params[:list_id])
    @item = Item.find(params[:id])

  end

  def update
    # @list = List.find(params[:id])
    # @list.update!(list_params)
    # redirect_to '/'

  end

  def destroy
    item = Item.find(params[:id])
    list = List.find(item.list_id)
    item.destroy
    redirect_to list
  end

  private
  def item_params
    return params[:item].permit(:description, :list_id)
  end


end
