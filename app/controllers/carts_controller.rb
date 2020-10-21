class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    # TODO: 
    # FIXME
    # QUESTION
    
        @carts = []
        if session[:cart_id] != nil
            @carts << Cart.find_by_id(session[:cart_id])
        end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)
    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
      @cart = current_cart
      @restaurant = @cart.restaurant
      @cart.destroy
      session[:cart_id] = nil
      respond_to do |format|
        format.html { redirect_to @restaurant}
        format.json { head :no_content }
    end
  end

  def order_group
  end

  def group_code
    if Cart.where(id: params[:group_code]).present?
      @cart = current_cart
      @restaurant = Restaurant.find(@cart.restaurant_id)
      redirect_to @restaurant
    else
      redirect_to order_group_carts_path, notice: 'The group code is incorrect!' 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end
end
