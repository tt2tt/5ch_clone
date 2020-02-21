class BoardsController < ApplicationController
  def index
    if params[:search]
      @category = Category.find(params[:search][:category_id])
      # @boards = Board.where(category_id: params[:search][:category_id])
      @boards = @category.boards
      @board = Board.new
    else
      @boards = Board.all
    end
  end

  def show
    @board = Board.find(params[:id])
    @response = Response.new
    @responses = @board.responses
  end

  def create
	  if current_user
      @board = current_user.boards.build(board_params)
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
	  params.require(:board).permit(:title, :content, { category_ids: [] })
	end
end
