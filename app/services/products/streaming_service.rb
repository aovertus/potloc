class Products::StreamingService
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def process
    product = Product.find_or_initialize_by(store: attributes["store"], model: attributes["model"])
    product.quantity = attributes["inventory"]
    product.save!
    content = product.attributes.merge(class: product.inventory_class) # Could move to a serializer such as Active Model Serializer
    ActionCable.server.broadcast "shop_channel", content: content
  rescue ActiveRecord::RecordInvalid => e
    # Report error to any third party service (Rollbar, Airbrake ...)
    Rails.logger.error e
  end
end
