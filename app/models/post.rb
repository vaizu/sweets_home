class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_genres, dependent: :destroy
  has_many :genres, through: :post_genres
  has_many :notifications, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :meterials, dependent: :destroy
  accepts_nested_attributes_for :recipes, :meterials, allow_destroy: true

  enum recipe_status: { レシピあり: 0, レシピなし: 1 }

  validates :post_name, presence: true
  validates :post_image, presence: true

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

  #通知機能
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "favorited"
    )
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end

    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )

    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end

