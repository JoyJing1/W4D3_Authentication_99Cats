class UserMailer < ActionMailer::Base
  default from: "everybody@appacademy.io"

  def welcome_email(user)
    @user = user
    @url = 'http://appacademy.io/'
    mail(to: user.username, subject: 'Welcome to My Awesome Cats Site')
  end

end
