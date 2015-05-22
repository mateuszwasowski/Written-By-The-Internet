class AddUserIdToParagraphs < ActiveRecord::Migration
  def change
    add_column :paragraphs, :user_id, :integer
  end
end
