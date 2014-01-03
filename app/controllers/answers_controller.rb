class AnswersController < ApplicationController
  layout 'student_survey', only: :new
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def new
    @response = Response.find(params[:response_id])
    @survey = @response.survey
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
      redirect_to thankyou_path 
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
      ss = connection.spreadsheet_by_title('Weekly Survey tst') 

      response = Response.find(params[:answer]["1"][:response_id])

      title = "Sheet1"
      ws = ss.worksheet_by_title(title)
      
      # use this piece of code if creating a new worksheet

      # if ws.nil?
      #   ws = ss.add_worksheet(title)
      #   last_row = 1 + ws.num_rows 
      #   ws[last_row, 1] = 'Time Submitted'
      #   ws[last_row, 2] = 'Who Was your Remote TA?'
      #   cur_col = 2
      #   params[:answer].each do |index, ans|
      #     cur_col += 1
      #     val = Question.find(ans[:question_id].to_i).content
      #     ws[last_row, cur_col] = val
      #   end
      # end

      last_row = 1 + ws.num_rows
      ws[last_row, 1] = Time.new

      params[:answer].each do |index, ans|
        case ans[:question_id].to_i
        when 1
          col = 9
        when 2
          col = 2
        when 3
          col = 3
        when 4
          col = 4
        when 5
          col = 7
        when 6
          col = 8
        when 9
          col = 6
        end
        ws[last_row, col] = ans[:content]
      end
      ws[last_row, 11] = response.bootcamp.staffs.find_by_position_id(1).user.first_name 
      ws[last_row, 12] = response.staff.user.first_name
      ws.save
    end
end
