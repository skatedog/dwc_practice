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
  has_many :favorite_books, through: :favorites, source: :book
  has_many :book_comments, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  def followed?(user)
    self.active_relationships.map { |active_relationship| active_relationship[:followed_id] }.include?(user.id)
  end

  def favorited?(book)
    self.favorites.map { |favorite| favorite[:book_id] }.include?(book.id)
  end

end
