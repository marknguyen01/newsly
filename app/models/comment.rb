class Comment < ApplicationRecord
    belongs_to :article, counter_cache: true
    belongs_to :user
    acts_as_votable
    validates :text, presence: true
end
