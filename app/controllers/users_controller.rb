class UsersController < Clearance::UsersController

  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize?, only: [:index]

  def index
    @users = User.all
  end

  def new
    @user =  user_from_params
    respond_to do |format|
      format.html {redirect_to sign_up_path}
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

  def show
  end

  def edit
  end

  def update
    if @user.update(permit_params)
      redirect_to @user
    else
      render 'edit'
    end

  end

  def destroy
    @user.destroy
    redirect_to root_path
  end


  private

  def find_user
    @user = User.find(params[:id])
  end

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
    params.require(:user).permit(:email, :password, :age, :gender, :role, :avatar, :remote_avatar_url)
  end

  def authorize?
    if current_user.role == "user"
      redirect_to root_path, alert: "Access Denied"
    else
      return true
    end
  end
end
