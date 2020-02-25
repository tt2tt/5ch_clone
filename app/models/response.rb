class Response < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :content, presence: true,  length: { maximum: 500 }

  scope :search_responses, -> (search_word){ where(['content LIKE ?', "%#{search_word}%"]).pluck(:board_id) }
end
