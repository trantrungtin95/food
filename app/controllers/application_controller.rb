class ApplicationController < ActionController::Base
    before_action :authorize
    
    private
     
    def current_cart
        Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
        cart = Cart.create()
        session[:cart_id] = cart.id
        cart
    end

    helper_method :current_cart

    protected
    def authorize
        @current_user = User.find_by(id: session[:user_id]) 
        if @current_user == nil
            redirect_to '/login', :notice => 'You must login first'
        end
    end


    def current_user
      @current_user
    end
    helper_method :current_user
end
