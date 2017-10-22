class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    render :new
  end

  def create
    @user = User.new(
      nickname: params[:nickname],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      bio: params[:bio])
    if @user.save()
      flash[:success] = "Welcome, #{@user.nickname}!" 
      redirect_to '/users'
    else
      flash[:warning] = "Invalid email/password!"
      redirect_to '/users/new'
    end
  end

  def update
    user = User.find_by(id: params[:user_id])
    User.update(user.id,
      bio: params[:bio])
    redirect_to "/users/#{user.id}"
  end
end
