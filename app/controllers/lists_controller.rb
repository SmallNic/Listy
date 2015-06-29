class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to '/'
    else
      render :new
    end
  end

  def show
    @list = List.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @list }
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    @list.update!(list_params)
    respond_to do |format|
      format.html { '/' }
      format.json { render json: @list } #this is the response for the AJAX call.
    end

    # respond_to do |format|
    #   if @list.update_attributes(list_params)
    #     format.html { redirect_to '/'}
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: "edit" }
    #     format.json { render json: @image.errors, status: :unprocessable_entity }
    #   end
    # end

  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to '/'
  end

  private

  def list_params
    return params[:list].permit(:title, :position_y, :position_x)
  end


end
