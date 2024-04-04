class Comment < ApplicationRecord
  belongs_to :expense, dependent: :destroy
end
