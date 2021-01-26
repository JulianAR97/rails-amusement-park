class UsersController < ApplicationController
  skip_before_action :verified_user, only: %i[new create]
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.id 
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(%i[name height happiness nausea tickets password admin])
  end
end
