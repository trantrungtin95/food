class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if @current_user.id != 1
      redirect_to root_path
    end
    @users = User.all
  end

  def my_orders
    @my_orders = @current_user.orders
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @restaurants = Restaurant.where(user_id: @user.id).paginate(:page => params[:page], :per_page => 10).order('created_at desc')
  end

  # GET /users/new
  def new
    if session[:user_id] == nil
      @user = User.new
    else
      redirect_to root_path
    end
  end

  # GET /users/1/edit
  def edit
    redirect_to root_path if @current_user.id != @user.id
  end

  def edit_email
    @user = User.find(params[:id])
    redirect_to root_path if @current_user.id != @user.id
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to sessions_new_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def shipper
    shipper=Shipper.create(user_id: @current_user.id, name: @current_user.name)
    redirect_to user_path(@current_user)
  end
  
  def unshipper
    shipper=Shipper.where(user_id: @current_user.id)
    shipper.destroy_all
    redirect_to user_path(@current_user)
  end

  def receive_order
    # attribute (column): role. User.fi
    @shipper = Shipper.where(user_id: @current_user.id).first
    shipper_order = ShipperOrder.create(shipper_id: @shipper.id, order_id: params[:order_id] )
    @order = Order.find(params[:order_id])
    @order.update(status: 'Processing')
    redirect_to @order
    ReceiveOrderMailer.received_order(@order, @current_user).deliver
  end
  
  def destroy_order_received
    user = User.find(params[:id])
    shipperorder = ShipperOrder.where(order_id: params[:order_id]).first
    order = shipperorder.order
    order.update(status: "Unprocessed")
    shipperorder.destroy
    redirect_to @current_user
    ReceiveOrderMailer.cancel_received_order(order,user).deliver
  end


  def orders_received
    user = User.find(params[:format])
    shipper = Shipper.where(user_id: user.id).first
    @shipper_orders = ShipperOrder.where(shipper_id: shipper.id)
    @orders_received = @shipper_orders.map(&:order)
  end


  def shipper_location
    if Shipper.where(user_id: @current_user.id).present?
      shipper = Shipper.where(user_id: @current_user.id).first
      shipper.update(latitude: params[:latitude])
      shipper.update(longitude: params[:longitude])
    end
  end

  def get_shipper_location
    if params[:shipper_id].blank?
    else
    shipper = Shipper.find(params[:shipper_id])
    render json: shipper.to_json(only: [:name, :latitude, :longitude])
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :hashed_password, :salt, :password, :password_confirmation, :email)
    end

end
