class BoardsController < ApplicationController
  def index
    @board = Board.new
    @response = Response.new
    if params[:search]
      @category = Category.find(params[:search][:category_id])
      @boards = @category.boards
    elsif params[:board]
      search_word = params[:board][:title]
      response_id = Response.search_responses(search_word)

      boards1 = Board.search_title(search_word)
      boards2 = Board.search_content(search_word)
      boards3 = Board.find(response_id)

      @boards = boards1 + boards2 + boards3
      @boards = @boards.uniq
    elsif params[:other]
      @boards = Board.other
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
        redirect_to @board
      else
        redirect_to root_path, flash: {error_messages: @board.errors.full_messages.join(';')}
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
