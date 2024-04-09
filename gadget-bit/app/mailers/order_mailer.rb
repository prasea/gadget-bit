class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_confirmation_email.subject
  #
  def order_confirmation_email
    @greeting = "Hi"
    @user = params[:user]
    @order = params[:order]  
    mail(to: @user.email, subject: 'Order Confirmation')
  end

  def new_order_email
    @order = params[:order]
    mail(to: 'parajanya.shrestha@bajratechnologies.com', subject: 'New Order Placed')
  end
end
