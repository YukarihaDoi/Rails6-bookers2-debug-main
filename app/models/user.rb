class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

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
　# has_many :xxx, class_name: "モデル名", foreign_key: "○○_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、そのユーザがフォローしている人orフォローされている人の一覧を出したい
  # has_many :yyy, through（通じて）: :xxx, source（紐づく）: :zzz


  # 検索分岐（usersテーブル内のカラム名を入れる)
  # ・完全一致→perfect_match
　# ・前方一致→forward_match
　# ・後方一致→backword_match
　# ・部分一致→partial_match
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end