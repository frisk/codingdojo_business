class BootcampsController < ApplicationController
  before_action :set_bootcamp, only: [:show, :edit, :update, :destroy]
  before_filter :authorize
  # GET /bootcamps
  # GET /bootcamps.json
  def index
    @bootcamps = Bootcamp.order('date DESC')
  end

  # GET /bootcamps/1
  # GET /bootcamps/1.json
  def show
    @surveys = @bootcamp.surveys.select('surveys.name, surveys.id as survey_id').group('surveys.id')
    @r_tas = @bootcamp.staffs.find_all_by_position_id(2)
  end

  # GET /bootcamps/new
  def new
    @bootcamp = Bootcamp.new
    @instructors = Position.find_by_name('Instructor').staffs.all
    @ta = Position.find_by_name('Remote TA').staffs.all
  end
  
  def new_feedback
    @bootcamp = Bootcamp.find(params[:bootcamp_id])
    @survey = Survey.find(params[:survey_id])
  end

  def create_feedback
    @info = params.require(:info).permit(:to, :from, :subject, :content, :survey_id, :bootcamp_id)
    SurveyMailer.survey_email(@info).deliver
    flash[:notice] = "Message sent to #{@info[:to]}"
    redirect_to bootcamps_path
  end

  # GET /bootcamps/1/edit
  def edit
    @instructors = Position.find_by_name('Instructor').staffs.all
    @ta = Position.find_by_name('Remote TA').staffs.all
    @staff = @bootcamp.staffs.all
  end

  # POST /bootcamps
  # POST /bootcamps.json
  def create
    @bootcamp = Bootcamp.new(bootcamp_params)

    if @bootcamp.save
      Bootcamp.find(@bootcamp.id).staffs = params.require(:staff).map {|s| Staff.find(s.to_i) }
      redirect_to @bootcamp, notice: 'Bootcamp was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /bootcamps/1
  # PATCH/PUT /bootcamps/1.json
  def update
    if @bootcamp.update(bootcamp_params)
      @bootcamp.staffs.destroy_all
      @bootcamp.staffs = params.require(:staff).map {|s| Staff.find(s.to_i) }
      redirect_to @bootcamp, notice: 'Bootcamp was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /bootcamps/1
  # DELETE /bootcamps/1.json
  def destroy
    @bootcamp.destroy
    respond_to do |format|
      format.html { redirect_to bootcamps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bootcamp
      @bootcamp = Bootcamp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bootcamp_params
      params.require(:bootcamp).permit(:title, :date, :group_email, :location_id)
    end
end
