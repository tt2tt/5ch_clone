class BoardCategory < ApplicationRecord
  belongs_to :board
  belongs_to :category
end
