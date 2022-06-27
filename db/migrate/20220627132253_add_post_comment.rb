class AddPostComment < ActiveRecord::Migration[6.1]
  def change
    t.integer :book_id
  end
end
