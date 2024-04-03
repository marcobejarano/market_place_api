class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index show create]
  
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

  def create
    order = current_user.orders.build(order_params)

    if order.save
      OrderMailer.send_confirmation(order).deliver
      render json: order, status: :created
    else
      render json: { errors: order.errors }, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:total, product_ids: [])
  end
end
