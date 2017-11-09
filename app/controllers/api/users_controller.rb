class Api::UsersController < ApplicationController

  def show_current
    @user = current_user
    render 'user.json.jbuilder'
  end
end
