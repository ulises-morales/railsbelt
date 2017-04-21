class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    # Log User In
    @user = User.find_by_email(params[:email])
    # if authenticate true
    if @user && @user.authenticate(params[:password])
      # save user id to session
      session[:user_id] = @user.id
      # redirect to ideas index page
      redirect_to "/ideas"
    # if authenticate false
    else
      # add an error message -> flash[:errors] = ["Invalid"]
      flash[:errors] = ["Invalid Credentials"]
      # redirect to login page
      redirect_to "/users/new"
    end
  end

  def destroy
    # Log User out
    # set session[:user_id] to null
    reset_session
    # redirect to login page
    redirect_to "/users/new"
  end
end
