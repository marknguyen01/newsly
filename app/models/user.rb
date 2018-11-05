class User < ApplicationRecord
    acts_as_authentic
    acts_as_voter
    has_many :comments
    def self.find_by_username_or_email(login)
        find_by_username(login) || find_by_email(login)
    end
end
