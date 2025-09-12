class Users::SessionsController < Devise::SessionsController
  def create
    super do |user|
      if params[:user][:remember_me] == "1"
        cookies[:user_email] = { value: user.email, expires: 2.weeks.from_now }
      else
        cookies.delete(:user_email)
      end
    end
  end
end
