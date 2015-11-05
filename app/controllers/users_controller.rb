class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
    @current_user = current_user
    @projects = @user.projects
  end

end