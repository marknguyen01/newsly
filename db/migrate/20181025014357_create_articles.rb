class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :slug, unique: true
      t.string :url
      t.string :imgURL
      t.string :author
      t.string :title
      t.string :date
      t.timestamps
    end
  end
end
