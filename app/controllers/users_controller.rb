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
      @message = "Sign Up Was Succesfull"
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      @message = "Sign Up Was Unsuccesfull"
      redirect_to root_path
    end
  end

  private

  def user_from_params
    user_params = params[:user] || Hash.new
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    age = user_params.delete(:age)
    gender = user_params.delete(:gender)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.age = age
      user.gender = gender
    end
  end

  def permit_params
    params.require(:user).permit(:email, :password, :age, :gender)
  end

end
