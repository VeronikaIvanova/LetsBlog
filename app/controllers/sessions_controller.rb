class SessionsController < ApplicationController


  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      sign_in user
      redirect_to user
    else
      render 'new'
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_url
  end

end
