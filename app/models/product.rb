class Product < ApplicationRecord

  validates :store, :model, :quantity, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def inventory_class
    # Could move into a decorator using Draper gem
    return 'high-inventory' if quantity > 66
    return 'normal-inventory' if quantity > 33
    'low-inventory'
  end
end
