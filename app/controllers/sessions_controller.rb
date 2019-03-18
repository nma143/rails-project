class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create

    if auth_hash = request.env["omniauth.auth"] #log in via facebook
      user = User.find_or_create_by_omniauth(auth_hash)
      session[:user_id] = user.id
      redirect_to user_path(user.id)

    else #regular log in
      @user = User.find_by(username: params[:user][:username])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        @user=User.new
        @user.username = params[:user][:username]
        @notice = "Invalid Login. Try again."
        render :new
      end
    end
  end

  def destroy
    session.destroy
    redirect_to root_url
  end

end
