class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
     redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end



  def user_params
    params.require(:user).permit(:name, :introduction, :user_image)
  end
end
