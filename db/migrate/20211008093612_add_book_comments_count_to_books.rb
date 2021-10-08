class AddBookCommentsCountToBooks < ActiveRecord::Migration[5.2]
  def self.up
    add_column :books, :book_comments_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :books, :book_comments_count
  end
end
