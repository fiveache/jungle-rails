class OrderMailer < ApplicationMailer

  def order_confirm(order)
    @order = order
    puts order
    mail(to: @order.email, subject: "Receipt for your order #{order.id}")
  end

end
