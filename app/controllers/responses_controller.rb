class ResponsesController < ApplicationController
  before_filter :authorize
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

  def index
    @bootcamp = Bootcamp.find(params[:bootcamp_id])
    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions.order("rated")
    @columns = @survey.questions.where(rated: 0).count
    @responses = @bootcamp.responses.find_all_by_survey_id(@survey.id)
    @rcount = @responses.count
  end

end
