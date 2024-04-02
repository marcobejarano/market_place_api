class Order < ApplicationRecord
  before_validation :set_total!
  
  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements

  validates :total, numericality: {
    greater_than_or_equal_to: 0
  }, presence: true

  after_commit :update_total, on: [:create, :update]

  private

  def set_total!
    self.total = products.sum(:price)
  end

  def update_total
    update_column(:total, products.sum(:price))
  end
end
