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
end
