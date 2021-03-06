class UsersController < ApplicationController
  helper_method :isCommentOwner?
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
    if !User.exists?(params[:id])
      redirect_to root_path
    else
      @user = User.find(params[:id])
      case params[:type]
      when "articles"
        @articles = @user.votes.up.for_type(Article).votables
      when "comments"
        @comments = @user.comments.all
      end
      render :show
    end
  end
  
  def edit
    authenticate_user(current_user)
    @user = User.find(params[:id])
    render :edit
  end
  
  def update
    authenticate_user(current_user)
    if User.update(users_params)
        flash[:success] = "Your account has been updated"
        redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "No permission"
      redirect_to root_path
    end
  end
  def destroy
    authenticate_user(current_user)
    User.find(params[:id]).destroy
    current_user_session.destroy
    redirect_to root_path
  end
  
  private def users_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
  private def authenticate_user(current_user)
    if !current_user.id.to_s == params[:id] || current_user.nil?
      flash[:danger] = "No permission"
      redirect_to root_path
    end
  end
end