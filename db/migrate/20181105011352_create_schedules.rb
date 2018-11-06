class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.text :article_slug
      t.timestamps
    end
  end
end
