class ResponsesController < ApplicationController
  layout 'student_survey', only: :new
  before_filter :authorize, only: [:all, :index]
  before_action :set_bootcamp, only: [:new, :index, :response_table, :statistics]
  before_action :set_survey, only: [:new, :all, :index, :response_table, :statistics]
  before_action :set_feedback_vars, only: [:index, :statistics]

  def new
  	@response = Response.new
    @staff = @bootcamp.staffs.find_all_by_position_id(2)
  end

  def create
  	@response = Response.new(params.require(:response).permit(:term, :survey_id, :staff_id, :bootcamp_id))
  	# redirect_to new_survey_response_answer_path(0, 0) if current_user
    if @response.save
  		redirect_to new_response_answer_path(@response.id)
  	end
  end

  def index
    @questions = @survey.questions.order("rated")
    @responses = @bootcamp.responses.order("term desc").find_all_by_survey_id(@survey.id)
    
  end

  def statistics
  end

  def all
    @bootcamps = Bootcamp.order("date desc").all
    @questions = @survey.questions.order("rated")
  end

  def response_table
    @responses = @bootcamp.responses.order("term desc").find_all_by_survey_id(@survey.id)
    @questions = @survey.questions.order("rated")
    render js: 'response_table'
  end

  def set_feedback_vars
    @ratings = Answer.find_by_sql("SELECT questions.short_content, avg(answers.content) as ratings FROM answers JOIN questions ON questions.id = answers.question_id JOIN responses ON responses.id = answers.response_id WHERE questions.rated = 't' AND responses.bootcamp_id = #{params[:bootcamp_id]} AND responses.survey_id = #{params[:survey_id]} GROUP BY responses.term, questions.id");
    @r_types = Question.find_all_by_rated('t')
    @r_type_end = @r_types.last
  end

  def set_bootcamp
    @bootcamp = Bootcamp.find(params[:bootcamp_id])
  end
  
  def set_survey
    @survey = Survey.find(params[:survey_id])
  end
end
