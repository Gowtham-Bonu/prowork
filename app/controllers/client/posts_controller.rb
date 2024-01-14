class Client::PostsController < ApplicationController
  before_action :create_empty_post, only: [:new]
  after_action :verify_authorized, only: [:index, :new, :create, :edit]
  before_action :get_post, only: [:edit, :update, :destroy]

  def index
    @posts = authorize [:client, Post.all]
  end

  def show; end

  def new
  end

  def create
    @post = authorize [:client, current_user.posts.build(post_params)]
    if @post.save
      redirect_to client_posts_path, notice: 'created post successfully'
    else
      flash.now[:alert] = 'post not created!'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to client_posts_path, notice: 'you have successfully updated the post'
    else
      flash.now[:alert] = 'the post has not been edited!'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      redirect_to client_posts_path, notice: 'you have successfully deleted the post'
    else
      flash.now[:alert] = [@post.errors.full_messages].join(", ")
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, {months: []}, :experience, {hourly_rate: []}, :project_budget, :description, :skill_list)
    end

    def create_empty_post
      @post = authorize [:client, Post.new]
    end

    def get_post
      @post = authorize [:client, Post.find(params[:id])]
    end
end 

