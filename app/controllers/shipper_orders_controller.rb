class ShipperOrdersController < ApplicationController
  class ShippersController < ApplicationController
    before_action :set_shipper_order, only: [:show, :edit, :update, :destroy]
  
    # GET /shippers
    # GET /shippers.json
    def index
      @shipper_orders = ShipperOrder.all
    end
  
    # GET /shippers/1
    # GET /shippers/1.json
    def show
    end
  
    # GET /shippers/new
    def new
      @shipper_order = ShipperOrder.new
    end
  
    # GET /shippers/1/edit
    def edit
    end
  
    # POST /shippers
    # POST /shippers.json
    def create
      @shipper_order = ShipperOrder.new(shipper_order_params)
  
      respond_to do |format|
        if @shipper_order.save
          format.html { redirect_to @shipper_order, notice: 'Shipper was successfully created.' }
          format.json { render :show, status: :created, location: @shipper_order }
        else
          format.html { render :new }
          format.json { render json: @shipper_order.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /shippers/1
    # PATCH/PUT /shippers/1.json
    def update
      respond_to do |format|
        if @shipper_order.update(shipper_order_params)
          format.html { redirect_to @shipper_order, notice: 'Shipper was successfully updated.' }
          format.json { render :show, status: :ok, location: @shipper_order }
        else
          format.html { render :edit }
          format.json { render json: @shipper_order.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /shippers/1
    # DELETE /shippers/1.json
    def destroy
      @shipper_order.destroy
      respond_to do |format|
        format.html { redirect_to shippers_url, notice: 'Shipper was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_shipper_order
        @shipper_order = Shipper.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def shipper_order_params
        params.require(:shipper_order).permit(:shipper_id, :order_id, :status)
      end
  end
  
end
