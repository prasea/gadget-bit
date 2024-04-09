class SendNewOrderEmailJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    OrderMailer.with(order: order).new_order_email.deliver_later
  end
end

