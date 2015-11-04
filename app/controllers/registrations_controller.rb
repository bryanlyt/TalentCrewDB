class RegistrationsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      flash[:notice] = "You have succesfully registered your account"
      redirect_to @user
    else
      render :new
    end
  end


  private
  # check for the permitted input for security
    def user_params
      params.require(:user)
        .permit(:username, :email, :password, :password_confirmation)
    end

end