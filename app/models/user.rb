class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #プロフィールイメージ
  has_one_attached :user_image

  has_many :posts, dependent: :destroy
  #いいね機能
  has_many :favorites, dependent: :destroy
  #コメント機能
  has_many :comments, dependent: :destroy
  #フォロー機能
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  #通知機能
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  #フォローする
  def follow(user_id)
    self.relationships.create!(followed_id: user_id)
  end
  #フォロー解除
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    self.followings.include?(user)
  end

  #プロフィールイメージ
  def get_user_image
    unless user_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image1.jpg')
      user_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    user_image.variant(resize_to_limit: [100, 100]).processed
  end

  #フォロー時の通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
