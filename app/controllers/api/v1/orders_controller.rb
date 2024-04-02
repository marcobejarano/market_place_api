class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index show]
  
  def index
    render json: OrderBlueprint.index_custom_render(current_user.orders)
  end

  def show
    order = current_user.orders.find(params[:id])

    if order
      render json: OrderBlueprint.custom_render(order)
    else
      head :not_found
    end
  end
end
