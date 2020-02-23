class Board < ApplicationRecord
  belongs_to :user
  has_many :board_categories, dependent: :destroy
  has_many :categories, through: :board_categories
  has_many :responses

  validates :title, presence: true,  length: { maximum: 100 }
  # validates :content, presence: true,  length: { maximum: 500 }
end
