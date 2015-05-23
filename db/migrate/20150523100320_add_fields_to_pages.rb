class AddFieldsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :text, :text
    add_column :pages, :page_id, :integer
  end
end
