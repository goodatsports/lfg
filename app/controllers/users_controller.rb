class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user, except: [:create, :new]

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
    user = User.new(
      nickname: params[:nickname],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      bio: params[:bio])
    if user.save()
      flash[:success] = "Welcome, #{user.nickname}!"
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      flash[:warning] = "Invalid email/password!"
      redirect_to '/users/new'
    end
  end

  def update
    begin
     res = request.env['omniauth.auth']
     id = res['uid']
     info = res['info']
    rescue
      flash[:error] = "Can't authorize you..."
    else
      puts info
      puts "STEAM ID: #{id}"
      puts "NICKNAME: #{info['nickname']}"
      puts "SUCCESS"
    end
     User.update(current_user.id,
       steam_id: id)
     flash[:success] = "Your steam account #{info['nickname']} is now linked, #{current_user.nickname}!"
     redirect_to "/users/#{current_user.id}"
   end
end
