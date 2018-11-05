class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :text
      t.string :article_id
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_reference :comments, :articles, index: true
  end
end
