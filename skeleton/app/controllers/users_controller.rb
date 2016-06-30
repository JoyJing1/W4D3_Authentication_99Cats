class UsersController < ApplicationController
  before_action :redirect_if_logged_in

  def new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      msg = UserMailer.welcome_email(user)
      msg.deliver

      user.reset_session_token!
      login!(user)
      redirect_to cats_url
    else
      render :new
    end
  end



  private
  def user_params
    params.require(:user).permit(:username, :password, :email)
  end

end
