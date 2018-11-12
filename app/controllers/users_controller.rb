class UsersController < ApplicationController
  def new
    @user = User.new
  end

  # create new user account
  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "Account registered!"
      redirect_to root_path
    else
      render :new
    end
  end
  
  def show
    render :show
  end
  
  def edit
    render :edit
  end

  private
  def users_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end