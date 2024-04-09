class SendOrderConfirmationEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id, order_id)
    user = User.find(user_id)
    order = Order.find(order_id)
    # OrderMailer.order_confirmation_email(user, order).deliver_later
    OrderMailer.with(user: user, order: order).order_confirmation_email.deliver_later
  end
end
