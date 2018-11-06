class Comment < ApplicationRecord
    belongs_to :article
    belongs_to :user
    acts_as_votable
end
