class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create

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

  def destroy
    session.destroy
    redirect_to root_url
  end

end
