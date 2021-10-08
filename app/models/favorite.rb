class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  counter_culture :book
  validates :user_id, uniqueness: { scope: :book_id }
end