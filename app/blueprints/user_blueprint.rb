class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :email

  def self.custom_render(user)
    hash_data = {}
    hash_data[:id] = user.id
    hash_data[:type] = "user"
    hash_data[:attributes] = {}
    hash_data[:attributes][:email] = user.email
    hash_data[:relationships] = {}
    hash_data[:relationships][:products] = {}
    hash_data[:relationships][:products][:data] = {}
    hash_data[:relationships][:products][:data] = user.products.map {
      |product| { id: product.id.to_s, type: "product" }
    }

    hash_included = user.products.map {
      |product| {
        id: product.id,
        type: "product",
        attributes: {
          title: product.title,
          price: product.price.to_s,
          published: product.published
        },
        relationships: {
          user: {
            data: {
              id: product.user.id,
              type: "user"
            }
          }
        }
      }
    }

    { "data": hash_data, "included": hash_included }
  end
end
