class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  cattr_accessor :current_user
end
