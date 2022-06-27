class AddBookIdToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments, :book_id, :integer
  end
end
