class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.string :name
      t.string :text
      t.string :article_id
      t.timestamps
    end
  end
end
