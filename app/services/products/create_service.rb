class Products::CreateService
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def process
    Product.find_or_initialize_by(store: attributes["store"], model: attributes["model"]) do |product|
      product.quantity = attributes["inventory"]
    end.tap { |p| p.save! }
  rescue ActiveRecord::RecordInvalid => e
    # Report error to any third party service (Rollbar, Airbrake ...)
    Rails.logger.error e
  end
end
