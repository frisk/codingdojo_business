class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def new
    @survey = Survey.find(params[:survey_id])
    @response = Response.find(params[:response_id])
    @bootcamp = @response.bootcamp
    @questions = @survey.questions.all
    @i = 0
  end

  def create
    @errors = false

    params[:answer].each do |index, ans|
      @answer = Question.find(ans[:question_id]).answers.new(content: ans[:content])
      @response = Response.find(ans[:response_id])
      @bootcamp = @response.bootcamp
      @answer.response_id = @response.id
      if @answer.save
        puts "#{@answer.id} created successfully"
      else
        puts @answer.errors.full_messages
        errors = true
      end
    end
    update_spreadsheet
    if !@errors
      render :thank_you 
    else
      render action: 'new'
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

    def update_spreadsheet
      connection = GoogleDrive.login(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"]) 
      ss = connection.spreadsheet_by_title('CodingDojo Bootcamp Students (July 29th)') 

      response = Response.find(params[:answer]["1"][:response_id])
      
      title = "Weekly Survey #{response.term}"
      ws = ss.worksheet_by_title(title)
      if ws.nil?
        ws = ss.add_worksheet(title)
        last_row = 1 + ws.num_rows 
        ws[last_row, 1] = 'Time Submitted'
        ws[last_row, 2] = 'Who Was your Remote TA?'
        cur_col = 2
        params[:answer].each do |index, ans|
          cur_col += 1
          val = Question.find(ans[:question_id].to_i).content
          ws[last_row, cur_col] = val
        end
      end

      last_row = 1 + ws.num_rows
      ws[last_row, 1] = Time.new
      ws[last_row, 2] = response.staff.first_name
      cur_col = 2  
      params[:answer].each do |index, ans|
        val = index.to_i
        col = cur_col + val
        ws[last_row, col] = ans[:content]
      end 
      ws.save
    end
end
