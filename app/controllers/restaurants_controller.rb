class RestaurantsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.paginate(:page => params[:page], :per_page => 10).order('created_at desc')
  end
  
  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @dishes = Dish.where(restaurant_id: @restaurant.id).paginate(:page => params[:page], :per_page => 10).order('created_at desc')
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
    redirect_to root_path if @current_user.id != @restaurant.user.id
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        if @current_user.status == :owner
        else
          @current_user.update(status: :owner)
        end
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    if @current_user.restaurants.count > 0
    else
      @current_user.update(status: :costomer)
    end
    respond_to do |format|
      format.html { redirect_to user_path(@current_user), notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    # address --> lattitude, longitude (geocoding)
    results = Geocoder.search(params[:query])
    @latitude = results.first.coordinates[0]
    @longitude = results.first.coordinates[1]
    # TODO: find restaurants near by
    @restaurants = Restaurant.near([@latitude, @longitude], 5)
  end

  def near_by
    restaurants = Restaurant.near([params[:latitude],params[:longitude]], 5)
    render json: restaurants.to_json(only: [:name, :latitude, :longitude])
  end

  def resvote
    @resvote = Resvote.create(user_id: @current_user.id, restaurant_id: params[:id], rating: params[:rate])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :user_id, :address, :open_time, :close_time, :latitude, :longitude)
    end
end
