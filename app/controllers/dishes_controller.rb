class DishesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_dish, only: [:show, :edit, :update, :destroy]

  # GET /dishes
  # GET /dishes.json
  def index
    puts "======================================"
    @dishes = Dish.paginate(:page => params[:page], :per_page => 10).order('created_at desc')
    # @dishes = Dish.none.paginate(:page => params[:page], :per_page => 10)
    @restaurants = []
    if params['q'].present?
      if params[:type] == "Restaurant"
        @restaurants = Restaurant.find_restaurants_name(params['q']).order('created_at desc').paginate(:page => params[:page], :per_page => 10)
      else
        @dishes = Dish.find_dishes_name(params['q']).order('created_at desc').paginate(:page => params[:page], :per_page => 10)
      end
    end 
  end

  # GET /dishes/1
  # GET /dishes/1.json
  def show
  end

  # GET /dishes/new
  def new
    @dish = Dish.new
  end

  # GET /dishes/1/edit
  def edit
    redirect_to root_path if @current_user.id != @dish.user_id
  end

  # POST /dishes
  # POST /dishes.json
  def create
    @dish = Dish.new(dish_params)

    respond_to do |format|
      if @dish.save
        format.html { redirect_to @dish, notice: 'Dish was successfully created.' }
        format.json { render :show, status: :created, location: @dish }
      else
        format.html { render :new }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dishes/1
  # PATCH/PUT /dishes/1.json
  def update
    respond_to do |format|
      if @dish.update(dish_params)
        format.html { redirect_to @dish, notice: 'Dish was successfully updated.' }
        format.json { render :show, status: :ok, location: @dish }
      else
        format.html { render :edit }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dishes/1
  # DELETE /dishes/1.json
  def destroy
    @dish.destroy
    respond_to do |format|
      format.html { redirect_to dishes_url, notice: 'Dish was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    @vote = Vote.create(user_id: @current_user.id, dish_id: params[:id], rate: params[:rate])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dish
      @dish = Dish.find(params[:id])
    end


    # Only allow a list of trusted parameters through.
    def dish_params
      params.require(:dish).permit(:name, :image_url, :price, :user_id, :restaurant_id)
    end
end
