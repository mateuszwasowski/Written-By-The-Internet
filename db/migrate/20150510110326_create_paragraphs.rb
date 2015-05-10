class CreateParagraphs < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.string :author
      t.text :parag
      t.boolean :main
      t.integer :main_id

      t.timestamps null: false
    end
  end
end
