class Response < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :content, presence: true,  length: { maximum: 500 }
end
