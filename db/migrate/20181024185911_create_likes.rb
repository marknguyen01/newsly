class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :vote, :default => 0
      t.string :article_id
      t.timestamps
    end
  end
end
