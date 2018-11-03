class Article < ApplicationRecord
  self.primary_key = "id"
  acts_as_votable
end
