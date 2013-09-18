class BootcampsController < ApplicationController
  before_action :set_bootcamp, only: [:show, :edit, :update, :destroy]
  before_filter :authorize
  # GET /bootcamps
  # GET /bootcamps.json
  def index
    @bootcamps = Bootcamp.all
  end

  # GET /bootcamps/1
  # GET /bootcamps/1.json
  def show
  end

  # GET /bootcamps/new
  def new
    @bootcamp = Bootcamp.new
  end

  # GET /bootcamps/1/edit
  def edit
  end

  # POST /bootcamps
  # POST /bootcamps.json
  def create
    @bootcamp = Bootcamp.new(bootcamp_params)

    respond_to do |format|
      if @bootcamp.save
        format.html { redirect_to @bootcamp, notice: 'Bootcamp was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bootcamp }
      else
        format.html { render action: 'new' }
        format.json { render json: @bootcamp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bootcamps/1
  # PATCH/PUT /bootcamps/1.json
  def update
    respond_to do |format|
      if @bootcamp.update(bootcamp_params)
        format.html { redirect_to @bootcamp, notice: 'Bootcamp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bootcamp.errors, status: :unprocessable_entity }
      end
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
      params.require(:bootcamp).permit(:title, :date)
    end
end
