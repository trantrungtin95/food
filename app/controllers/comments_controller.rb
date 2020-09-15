class CommentsController < ApplicationController
  before_action :find_restaurant
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @parent_comment = Comment.find_by(id: params[:comment_id])
  end

  # GET /comments/1/edit

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.restaurant_id = params[:restaurant_id]
    @parent_comment = Comment.find_by(id: comment_params[:comment_id])
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to restaurant_path(@restaurant)
  end

  def edit 
    redirect_to root_path if @current_user.id != @comment.user_id 
  end

  def update
    if @comment.update(comment_params)
      redirect_to restaurant_path(@restaurant)
    else
      render 'edit'
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end


    def find_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:user_id, :restaurant_id, :content, :comment_id)
    end
end
