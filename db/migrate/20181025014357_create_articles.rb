class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles, id: false do |t|
      t.string :id
      t.string :url
      t.string :imgURL
      t.string :author
      t.string :title
      t.string :date
      t.timestamps
      t.index :id, unique: true
    end
  end
end
