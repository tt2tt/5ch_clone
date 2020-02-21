class Category < ApplicationRecord
  has_many :board_categories, dependent: :destroy
  has_many :boards, through: :board_categories

  validates :name, presence: true,  length: { maximum: 30 }
end
