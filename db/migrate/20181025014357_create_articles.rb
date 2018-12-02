class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :slug, unique: true
      t.string :url
      t.string :imgURL
      t.string :author
      t.string :title
      t.string :date
      t.integer :views_count, :default => 0
      t.integer :comments_count, :default => 0
      t.integer :votes_count, :default => 0
      t.timestamps
    end
  end
end
