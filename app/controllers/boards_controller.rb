class BoardsController < ApplicationController
  def index
    if params[:search]
      @boards = Board.where(category_id: params[:search][:category_id])
    else
      @boards = Board.all
    end
  end
end
