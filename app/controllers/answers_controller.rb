class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @survey = Survey.find(params[:survey_id])
    @response = Response.find(params[:response_id])
    @bootcamp = @response.bootcamp
    @questions = @survey.questions.all
    @i = 0
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    # render text: params[:answer]
    errors = false
    params[:answer].each do |index, ans|
      @answer = Question.find(ans[:question_id]).answers.new(content: ans[:content])
      @answer.response_id = Response.find(ans[:response_id]).id
      if @answer.save
        puts "#{@answer.id} created successfully"
      else
        puts @answer.errors.full_messages
        errors = true
      end
    end
    render :thank_you if !errors
    # @answer = Answer.new(answer_params)
    # respond_to do |format|
    #   if @answer.save
    #     format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @answer }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @answer.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:content, :question_id, :response_id)
    end
end
