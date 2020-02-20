class BoardsController < ApplicationController
  def index
    @boards = Board.all
    # @board = Board.new
  end
end
