class AddFieldsToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :user_id, :integer
  end
end
