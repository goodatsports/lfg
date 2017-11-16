class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token 
  
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Hey #{user.nickname}!"
      redirect_to root_path
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logout Successful!"
    redirect_to '/login'
  end

end
