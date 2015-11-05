class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      login user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_path
    else
      flash[:error] = "Invalid email / password combination"
      redirect_to new_login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end
