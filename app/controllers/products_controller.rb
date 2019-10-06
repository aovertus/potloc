class ProductsController < ApplicationController
  def index
    @store_products = Product.all.group_by(&:store)
  end
end
