  class OrderMailer < ApplicationMailer
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
