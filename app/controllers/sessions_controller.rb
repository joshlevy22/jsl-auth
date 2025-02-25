class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
    # authenticate the user
    # 1. try to find the user by their unique identifier
    @user = User.find_by({"email" => params["email"]})
    # 2. if the user exists -> check if they know their password
    if @user.present?
      if BCrypt::Password.new(@user["password"]) == params["password"]
        cookies["name"] = "Cookie Monster"
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome."
        redirect_to "/companies"
      else 
        flash["notice"] = "Nope."
        redirect_to "/login"
    end
  end
  end

  def destroy
    # logout the user
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end
