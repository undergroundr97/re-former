class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    existing_user = User.find_by(username: user_params[:username])
    # @user = User.new(user_params)
    if existing_user
      existing_user.update(user_params)
      redirect_to new_users_path
    else
      @user = User.new(user_params)
      if @user.save
        redirect_to new_users_path, notice: "wel done"
      else
        render new_users_path, notice: "error"
      end
    end
  end


  def edit
  end
  def update
    @user = User.find(params[:username])
    if @user.update(user_params)
      redirect_to new_users_path, notice: "User updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
