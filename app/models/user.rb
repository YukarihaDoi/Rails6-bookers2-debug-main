class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :book
 
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy


  has_one_attached :profile_image

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # 自分がフォローしてる人
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed

  # 自分をフォローしている人
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_user, through: :followed, source: :follower

  # フォローする
  def follow(user_id)
  follower.create(followed_id: user_id)
  end

  # フォロー外す
  def unfollow(user_id)
  follower.find_by(followed_id: user_id).destroy
  end

 # フォロー確認
  def following?(user)
  following_user.include?(user)
  end

  # 検索
  def self.search_for(content, method)
    if method == "perfect_match"
      User.where(name:content)
    elsif method == "forward_match"
      User.where('name LIKE ?', content+'%')
    elsif method == "backward_match"
      User.where('name LIKE ?', '%'+content)
    elsif method == "partial_match"
      User.where('name LIKE ?', '%'+content+'%')
    else
      User.all
    end
  end
end

