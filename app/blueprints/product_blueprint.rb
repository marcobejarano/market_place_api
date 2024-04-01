class ProductBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :price, :published

  association :user, blueprint: UserBlueprint

  def self.custom_render(product)
    hash_data = {}
    hash_data[:id] = product.id.to_s
    hash_data[:type] = "product"
    hash_data[:attributes] = {
      title: product.title,
      price: product.price.to_s,
      published: product.published
    }
    hash_data[:relationships] = {}
    hash_data[:relationships][:user] = {}
    hash_data[:relationships][:user][:data] = {}
    hash_data[:relationships][:user][:data][:id] = product.user.id.to_s
    hash_data[:relationships][:user][:data][:type] = "user"

    hash_included = []
    
    user_hash = {}
    user_hash[:id] = product.user.id.to_s
    user_hash[:type] = "user"
    user_hash[:attributes] = {}
    user_hash[:attributes][:email] = product.user.email

    hash_included << user_hash

    { "data": hash_data, "included": hash_included }
  end
end
