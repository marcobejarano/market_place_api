class Order < ApplicationRecord
  validates :total, numericality: {
    greater_than_or_equal_to: 0
  }, presence: true

  belongs_to :user
end
