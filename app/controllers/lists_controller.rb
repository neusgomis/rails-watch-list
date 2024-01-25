class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(set_params)
    @list.save
    redirect_to list_path(@list)
  end

  private

  def set_params
    params.require(:list).permit(:name)
  end
end
