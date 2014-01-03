class StaffsController < ApplicationController
  before_filter :authorize
  def index
    @staffs = Staff.all
  end

  def show
  end

  def new
    @user = User.new
    @positions = Position.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @staff = User.find(@user.id).staffs.new(staff_params)
      if @staff.save
        redirect_to staffs_url
      else
        render text: "could not create staff member" 
      end
    else
      render text: "could not create user"
    end
  end

  def edit
    @staff = Staff.find(params[:id])
    @user = @staff.user
    @positions = Position.all
  end

  def update
  end

  def destroy
  end

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
  def staff_params
      params.require(:staff).permit(:position_id)
  end
end
