class Article < ApplicationRecord
  self.primary_key = :id
  acts_as_votable
  has_many :comments
end
