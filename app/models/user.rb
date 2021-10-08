class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, uniqueness: true, length: { in: 2..20}
  validates :introduction, length: { maximum: 50 }

  has_one_attached :image
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def already_favorited?(book)
    self.favorites.where(book_id: book.id).present?
  end
end
