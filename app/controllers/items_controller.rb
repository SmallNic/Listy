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
    @item.completed = false
    if @item.save
      redirect_to "/lists/#{params[:list_id]}"
    else
      render :new
    end

  end


  # t.datetime "due_date"
  # t.boolean  "completed"

  def show
    @item = Item.find(params[:id])
    render json: @item
  end

  def edit
    @list = List.find(params[:list_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update!(item_params)
    @list = List.find(@item.list_id)
    # redirect_to list_path(@list)
    # redirect_to :controller => "lists", :action => "show", :id => @list.id
    respond_to do |format|
      format.html { redirect_to(list_path(@list)) }
      format.json { render json: @list } #this is the response for the AJAX call.
    end


  end

  def destroy
    item = Item.find(params[:id])
    list = List.find(item.list_id)
    item.destroy
    redirect_to list
  end

  private
  def item_params
    return params[:item].permit(:description, :list_id, :completed)
  end


end
