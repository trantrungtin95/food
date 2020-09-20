class ReceiveOrderMailer < ApplicationMailer
    default from: 'trungtinbkit@gmail.com'
    def cancel_received_order(order,user)   
        @order = order
        @user = user
        mail :to => @order.email, :subject => "#{@user.name} has refused to accept your order!"
    end

    def received_order(order,user)
        @order = order
        @user = user
        mail :to => @order.email, :subject => "#{@user.name} has accept your order!"
    end
end
