class StoreController < ApplicationController
  skip_before_action :authorize
  def index
    @dishes = Dish.paginate(:page => params[:page], :per_page => 10).order('created_at desc')
    @cart = current_cart
  end
end
