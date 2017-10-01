class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    @user = User.new(
      nickname: params[:nickname],
      email: params[:email],
      password: params[:password],
      bio: params[:bio])
    if @user.save()
      redirect_to '/users'
    else
      flash[:warning] = "Invalid password/email!"
      redirect_to :new
    end

  end
end
