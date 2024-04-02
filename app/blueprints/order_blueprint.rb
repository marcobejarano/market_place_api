class OrderBlueprint < Blueprinter::Base
  identifier :id

  fields :total

  association :user, blueprint: UserBlueprint
  association :products, blueprint: ProductBlueprint

  def self.index_custom_render(orders)
    hash_data = orders.map {
      |order| {
        id: order.id.to_s,
        type: "order",
        attributes: {
          total: order.total
        },
        relationships: {
          user: {
            data: {
              id: order.user.id.to_s,
              type: "user"
            }
          }
        }
      }
    }

    hash_included = []
    
    user_hash = {}
    user_hash[:id] = orders[0].user.id.to_s
    user_hash[:type] = "user"
    user_hash[:attributes] = {}
    user_hash[:attributes][:email] = orders[0].user.email

    hash_included << user_hash

    { "data": hash_data, "included": hash_included }
  end

  def self.custom_render(order)
    hash_data = {}
    hash_data[:id] = order.id
    hash_data[:type] = "order"
    hash_data[:attributes] = {}
    hash_data[:attributes][:total] = order.total
    hash_data[:relationships] = {}
    hash_data[:relationships][:products] = {}
    hash_data[:relationships][:products][:data] = order.products.map {
      |product| { id: product.id, type: "product" }
    }

    hash_included = order.products.map {
      |product| {
        id: product.id,
        type: "product",
        attributes: {
          title: product.title,
          price: product.price.to_s,
          published: product.published
        }
      }
    }

    { "data": hash_data, "included": hash_included }
  end
end
