class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create

    if auth_hash = request.env["omniauth.auth"] #log in via facebook

      auth_email = auth_hash[:extra][:raw_info][:email]

      # If not first time this email has been used to log in, just log them in
      if user = User.find_by(:email => auth_email)
        session[:user_id] = user.id
        redirect_to user_path(user.id)

      # If this is the first time this email has been used:
      # create a user with the auth_email, make a username for them, and give fake password
      else

        auto_username = User.create_username_from_email(auth_email)
        fake_password = SecureRandom.hex
        user = User.new(username: auto_username, email: auth_email, password: fake_password)
        if user.save
          session[:user_id] = user.id
          redirect_to user_path(user.id)
        else
          render :new
        end
      end

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
