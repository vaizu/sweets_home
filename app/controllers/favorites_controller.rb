class FavoritesController < ApplicationController

  def create
    @post_favorite = Favorite.new(user_id: current_user.id, post_id: params[:post_id])
    @post_favorite.save
    @post = Post.find(params[:post_id])
    @post.create_notification_by(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    @post_favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
    @post_favorite.destroy
    redirect_to request.referer
  end


end
