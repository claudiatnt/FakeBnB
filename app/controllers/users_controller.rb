class UsersController < Clearance::UsersController

  def new
    @user =  user_from_params
    respond_to do |format|
      format.html {redirect_to "/sign_up"}
      format.js
    end
  end

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      message = "Sign Up Was Succesfull"
      respond_to do |format|
        format.html { redirect_to "/" }
        format.js
      end
    else
      message = "Sign Up Was Unsuccesfull"
      redirect_to "/"
    end
  end

end
