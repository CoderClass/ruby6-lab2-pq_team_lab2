class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save!
      session[:user_id] = @user.id
      flash[:success] = "User created successful!"
      redirect_to user_path(id: @user.id)
    else
      raise @user.errors.full_messages.to_sentence
      flash[:error] = "Error: #{@user.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def index
    @users = User.all.shuffle
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
