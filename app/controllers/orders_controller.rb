class OrdersController < ApplicationController
  skip_before_action :authorize, :only => [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @shipper = Shipper.where(user_id: current_user.id).first
    if @current_user.shipper_by(@current_user)
      
      @orders = Order.all
    else
      redirect_to root_path
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @cart = current_cart
    if @cart.line_items.empty?
        redirect_to '/', :notice => 'Your cart is empty'
        return
    end
    @restaurant = Restaurant.find(params[:restaurant_id])
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @restaurant = Restaurant.find(params[:order][:restaurant_id])
      if params[:order][:coupon_code] != "" 
        @coupon_code = @restaurant.coupon_codes.where(status: "not_over").first
        discount = @coupon_code.discount
      else
        discount = 0
      end
    # always create order
    # if coupon code is wrong, no discount
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(current_cart)
    respond_to do |format|
      if @order.update(discount: discount)
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrdermailMailer.order_received(@order).deliver
        format.html { redirect_to line_items_path(order_id: @order.id), notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to restaurant_order_path(@restaurant, @order), notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to @current_user, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def completed
    @order = Order.find(params[:id])
    @order.update(status: 'Processed')
    @restaurant = Restaurant.find(@order.restaurant_id)
    ShipperOrder.where(order_id: @order.id).first.update(status: "Processed")
    redirect_to restaurant_order_path(@restaurant, @order)
  end

  def get_location_restaurants
    order = Order.find(params[:order_id])
    restaurants = order.line_items.map(&:dish).map(&:restaurant)
    render json: restaurants.to_json(only: [:name, :latitude, :longitude])
  end

  def chat
    @order = Order.find(params[:id])
    @roomchat = Roomchat.create(order_id: params[:id], 
                                sender_id: params[:roomchat][:sender_id],
                                sender_name: params[:roomchat][:sender_name],
                                content: params[:message]
                                )

    # redirect_to line_items_path(@order) # User for html request
  end 

  def chat_rooms
    order = Order.find(params[:order_id])
    roomchats = order.roomchats
    render json: roomchats.to_json(only: [:sender_name, :content, :created_at])
  end

  def shippervote
    shippervote = Shippervote.create(
                                      user_id: @current_user.id, 
                                      shipper_id: params[:shipper_id], 
                                      order_id: params[:id],
                                      rating: params[:rating]
                                    )
  end

  def uservote
    order = Order.find(params[:id])
    uservote = Uservote.create(
                                user_id: order.user_id,
                                shipper_id: params[:shipper_id],
                                order_id: params[:id],
                                rating: params[:rating]
                                )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type, :user_id, :status, :restaurant_id, :coupon_code)
    end
end
