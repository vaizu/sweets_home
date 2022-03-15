class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_genres, dependent: :destroy
  has_many :genres, through: :post_genres
  has_many :recipes, dependent: :destroy
  has_many :meterials, dependent: :destroy
  accepts_nested_attributes_for :recipes, :meterials, allow_destroy: true

  enum recipe_status: { レシピあり: 0, レシピなし: 1 }

  #いいね
  def favorited?(user)
     favorites.where(user_id: user.id).exists?
  end

  #投稿画像
  def get_post_image
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image1.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [500, 500]).processed
  end
end

