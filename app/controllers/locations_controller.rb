class LocationsController < ApplicationController
	before_filter :authorize
	def index
		@locations = Location.all
	end
	def edit
		@location = Location.find(params[:id])
	end
	def update
		@location = Location.find(params[:id])
		if @location.update(location_params)
			redirect_to locations_path, notice: "Location updated"
		else
			render :edit
		end
	end
	def new
		@location = Location.new
	end
	def create
		@location = Location.new(location_params)

		if(@location.save)
			redirect_to locations_path, notice: "Location created successfully"
		else
			render :new
		end
	end
	
	private
	def location_params
      params.require(:location).permit(:city, :state)
    end
end
