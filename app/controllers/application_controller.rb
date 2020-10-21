class ApplicationController < ActionController::Base
    before_action :authorize
    
    private
     
    def current_cart
        Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
        if !params[:restaurant_id].nil? && !params[:dish_id].nil?
            cart = Cart.create(user_id: @current_user.id, restaurant_id: params[:restaurant_id])
        elsif !params[:group_code].nil?
            cart = Cart.find(params[:group_code])
        else
            cart = Cart.create()
        end
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
