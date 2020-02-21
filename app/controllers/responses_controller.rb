class ResponsesController < ApplicationController
  def create
    if current_user
      @response = current_user.responses.build(response_params)
      if @response.save
        redirect_to categories_path
      else
        redirect_to categories_path
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
