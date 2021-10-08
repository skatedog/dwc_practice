class BookComment < ApplicationRecord
  validates :body, presence: true

  belongs_to :user
  belongs_to :book
  counter_culture :book
end
