class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.user_level = 1
      session[:user_id] = @user.id
      redirect_to account_path, :notice => "Signed up!"
    else
      render "new"
    end
  end
  
  def show
    @user = User.find_by_id(session[:user_id])
  end
  
  private 
  
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
end
