class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create

    if auth_hash = request.env["omniauth.auth"]

      email = auth_hash[:extra][:raw_info][:email]
      name = auth_hash[:extra][:raw_info][:name] #e.g. Jane Smith

      # If not first time this email has been used to log in, just log them in
      if User.find_by(:email => email)
        raise "You already exist"

      # If this is the first time this email has been used:
      # create a user with facebook email, change facebook user name to meet db requirements, and give fake password
      else
        raise "You don't exist"
        

      end

    else
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
