class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:user_image)
  end
end
