class GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:id])
    @genres = @genre.posts.page(params[:page]).per(8)
  end
end
