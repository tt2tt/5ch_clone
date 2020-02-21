class BoardsController < ApplicationController
  def index
    if params[:search]
      @boards = Board.where(category_id: params[:search][:category_id])
      @board = Board.new
    else
      @boards = Board.all
    end
  end

  def create
    @board = current_user.boards.build(board_params)
	  if current_user
      if @board.save
        redirect_to categories_path
      else
        redirect_to categories_path
      end
    else
      redirect_to user_session_path
    end
  end

  private

	def board_params
	  params.require(:board).permit(:title, :content, :category_id)
	end
end
