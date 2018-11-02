class Upvote < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :article, uniqueness: { scope: :user }
  validates :user, uniqueness: { scope: :post }
end
