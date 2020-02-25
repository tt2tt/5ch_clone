class ResponsesController < ApplicationController
  def create
    if current_user
      @response = current_user.responses.build(response_params)
      @board = Board.find( params[:board_id])
      if @response.save
        redirect_to @board
      else
        redirect_to @board, flash: {error_messages: @response.errors.full_messages.join(';')}
      end
    else
      redirect_to user_session_path
    end
  end

  private

	def response_params
	  params.permit(:content, :response_number, :board_id)
	end
end
