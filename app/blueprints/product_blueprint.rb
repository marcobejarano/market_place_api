class ProductBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :price, :published
end
