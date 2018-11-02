class Article < ApplicationRecord
  self.primary_key = "id"
  has_many :upvotes, dependent: :destroy
  def score
    upvotes.count
  end
end
