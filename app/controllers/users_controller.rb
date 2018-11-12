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
    @articles = User.find(params[:id]).votes.up.for_type(Article).votables
    render :show
  end
  
  def edit
    if current_user.id.to_s == params[:id] && !current_user.nil?
      @user = User.find(params[:id])
      render :edit
    else
      flash[:danger] = "You don't have permission to view this"
      redirect_to root_path
    end
  end
  
  private
  def users_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end