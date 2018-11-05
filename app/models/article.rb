class Article < ApplicationRecord
  self.primary_key = :id
  acts_as_votable
  has_many :comments
  def to_param
    slug
  end
end
