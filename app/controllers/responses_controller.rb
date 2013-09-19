class ResponsesController < ApplicationController
  def new
  	@bootcamp = Bootcamp.find(params[:bootcamp_id])
  	@survey = Survey.find(params[:survey_id])
  	@response = Response.new 
  end

  def create
  	@response = Response.new(params.require(:response).permit(:term, :survey_id, :staff_id, :bootcamp_id))
  	redirect_to new_survey_response_answer_path(0, 0) if current_user
    if @response.save
  		redirect_to new_survey_response_answer_path(@response.survey_id, @response.id)
  	end
  end
end
