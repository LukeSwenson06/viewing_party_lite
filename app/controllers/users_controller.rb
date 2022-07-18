class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @viewing_partys = @user.viewing_partys
    # require "pry"; binding.pry
  end

  def create
    # user = user_params
    # user[:email] = user[:email].downcase
    new_user = User.new(user_params)
    if new_user.save
      flash[:success] = 'Account Successfully Created!'
      session[:user_id] = new_user.id
      redirect_to user_path(new_user.id)
    else
      flash[:error] = new_user.errors.full_messages
      redirect_to register_path
    end
  end

  def discover
    @user = User.find(params[:user_id])
  end

  def login_form

  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      redirect_to user_path(user.id)
    else
      redirect_to '/login'
      flash[:error] = 'Invalid Credentials'
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end
end
