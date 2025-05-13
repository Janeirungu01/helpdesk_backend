class Article < ApplicationRecord
  # You can add validations here
  # serialize :tags, JSON
  validates :question, :answer, :category, presence: true

end

