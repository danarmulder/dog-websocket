class UsersController < ApplicationController

  def profile
    user = current_user
    blocked_user_ids = user.blocked_users
    @blocked_users = []
    @conversations = Conversation.where("(conversations.sender_id = ? ) OR (conversations.recipient_id =?)", user.id, user.id)
    blocked_user_ids.each do |blocked_id|
      @conversations = @conversations.where.not("(conversations.sender_id = ? ) OR (conversations.recipient_id =?)", blocked_id.content.to_i, blocked_id.content.to_i)
    end
    @dogs = Dog.where.not(user_id: user.id)
    @filters = user.filters
    @filters.each do |filter|
      @dogs = filter.filter(@dogs)
    end
    @users_dogs = current_user.dogs
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path
      flash[:notice] = "Profile successfully updated"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @dogs = @user.dogs
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
      :avatar,
      :password,
      :password_confirmation
    )
  end
end
