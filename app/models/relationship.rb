class Relationship < ApplicationRecord

belongs_to :follower, class_name: "User"
belongs_to :followed, class_name: "User"

has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
# has_many :xxx, class_name: "モデル名", foreign_key: "○○_id", dependent: :destroy

has_many :followings, through: :relationships, source: :followed 

end
