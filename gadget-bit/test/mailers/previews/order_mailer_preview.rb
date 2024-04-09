# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/order_confirmation_email
  def order_confirmation_email
    OrderMailer.with(user: User.first, order: Order.first).order_confirmation_email
  end

end
