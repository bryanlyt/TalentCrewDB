class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by(username: params[:login][:username].downcase)
    if user && user.authenticate(params[:login][:password])
      login user
      params[:login][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash[:error] = "Invalid username / password"
      redirect_to new_login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end

