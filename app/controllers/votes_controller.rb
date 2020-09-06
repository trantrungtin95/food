class VotesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_dish, only: [:show, :edit, :update, :destroy]
    def index
        @votes = Vote.all
      end
    
      # GET /line_items/1
      # GET /line_items/1.json
      def show
      end
    
      # GET /line_items/new
      def new
        @vote = Vote.new
      end
    
      # GET /line_items/1/edit
      def edit
      end
    
      # POST /line_items
      # POST /line_items.json
      def create
        if Vote.where(user_id: @current_user.id, dish_id: params[:dish_id]).present?
            Vote.where(user_id: @current_user.id, dish_id: params[:dish_id]).destroy_all
            @vote = Vote.new(user_id: @current_user.id, dish_id: params[:dish_id], rate: params[:type])
        else
          @vote = Vote.new(user_id: @current_user.id, dish_id: params[:dish_id], rate: params[:type])
        end
        respond_to do |format|
          if @vote.save
            format.html { redirect_to dish_path(@vote.dish) }
            format.js   {@vote}
            format.json { render :show, status: :created, location: @vote }
          else
            format.html { render :new }
            format.json { render json: @vote.errors, status: :unprocessable_entity }
          end
        end
      end
    
      # PATCH/PUT /line_items/1
      # PATCH/PUT /line_items/1.json
      def update
        respond_to do |format|
          if @vote.update(vote_params)
            format.html { redirect_to '/' }
            format.json { render :show, status: :ok, location: @vote }
          else
            format.html { render :edit }
            format.json { render json: @vote.errors, status: :unprocessable_entity }
          end
        end
      end
    
      # DELETE /line_items/1
      # DELETE /line_items/1.json
      def destroy
        @vote.destroy
        respond_to do |format|
          format.html { redirect_to '/'}
          format.json { head :no_content }
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_vote
          @vote = Vote.find(params[:id])
        end
    
        # Only allow a list of trusted parameters through.
        def vote_params
          params.require(:vote).permit(:user_id, :dish_id, :rate)
        end
end
