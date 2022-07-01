class Relationship < ApplicationRecord

# フォローする人（参照モデルUser)
belongs_to :follower, class_name: "User"
# フォローされる人（参照モデルUser)
belongs_to :followed, class_name: "User"

end
