class HomesController < ApplicationController
  def top
    @posts = Post.order('id DESC').limit(4)
  end
end
