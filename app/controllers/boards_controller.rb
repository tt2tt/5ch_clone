class BoardsController < ApplicationController
  def index
    if params[:search]
      @category = Category.find(params[:search][:category_id])
      # @boards = Board.where(category_id: params[:search][:category_id])
      @boards = @category.boards
      @board = Board.new
      @response = Response.new
    elsif params[:board]
      search_word = params[:board][:title]
      search_by_boards1 = Board.where(['title LIKE ?', "%#{search_word}%"])
      search_by_responses = Response.where(['content LIKE ?', "%#{search_word}%"])
      search_ids = search_by_responses.pluck(:board_id).uniq
      search_by_boards2 = Board.find(search_ids)
      @boards = search_by_boards1 + search_by_boards2
      @boards.uniq
      @response = Response.new
      @board = Board.new
      # binding.pry
      # @boards = Board.where(['title LIKE ?', "%#{search_word}%"])
    elsif params[:other]
      @boards = Board.left_joins(:categories).select("boards.*").where("categories.name is null")
      @response = Response.new
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
