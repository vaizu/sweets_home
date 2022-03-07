class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :user
  has_many :post_genres, dependent: :destroy
  has_many :genres, through: :post_genre, dependent: :destroy

  enum recipe_status: { レシピあり: 0, レシピなし: 1 }

  def get_post_image
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image1.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [100, 100]).processed
  end
end

