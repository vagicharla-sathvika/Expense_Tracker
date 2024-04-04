class Expense < ApplicationRecord
  belongs_to :employee
  has_many :comments, dependent: :destroy
end
