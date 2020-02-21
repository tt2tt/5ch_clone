class Board < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :board_categories, dependent: :destroy
  has_many :categories, through: :board_categories
end
