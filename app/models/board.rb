class Board < ApplicationRecord
  belongs_to :user
  has_many :board_categories, dependent: :destroy
  has_many :categories, through: :board_categories
  has_many :responses

  validates :title, presence: true,  length: { maximum: 100 }
  validates :content,  length: { maximum: 500 }

  scope :search_title, -> (search_word){ where(['title LIKE ?', "%#{search_word}%"]) }
  scope :search_content, -> (search_word){ where(['content LIKE ?', "%#{search_word}%"]) }
  scope :other, -> { left_joins(:categories).select("boards.*").where("categories.name is null") }
end
