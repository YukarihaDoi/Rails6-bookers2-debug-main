class Book < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
 # 検索方法分岐(booksテーブル内のカラム名を入れる)
 # ・完全一致→perfect_match
 # ・前方一致→forward_match
 # ・後方一致→backword_match
 # ・部分一致→partial_match
  
  def self.search_for(content, method)
    if method == "perfect_match"
      Book.where(title:content)
    elsif method == "forward_match"
      Book.where('title LIKE?',content+'%')
    elsif method == "backward_match"
      Book.where('title LIKE?','%'+content)
    elsif method == "partial_match"
      Book.where('title LIKE?','%'+content+'%')
    else
      Book.where('title LIKE?',content+'%')
    end
  end
end