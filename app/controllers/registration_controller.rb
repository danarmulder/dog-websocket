class RegistrationController < ApplicationController

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_dog_path
    else
      render :new
      flash[:alert]= "User could not be signed up"
    end

  end

  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :zipcode,
      :age,
      :bio,
      :gender,
      :password,
      :password_confirmation
    )
  end
end
