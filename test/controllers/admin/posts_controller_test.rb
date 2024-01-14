require "test_helper"

class Client::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:post_one)
    @user = users(:user_one)
    @user.confirm
    @user.add_role :client
    sign_in @user
  end

  test "should get index" do
    get root_url
    assert_response :success
  end

  test 'should not get index without sign in' do
    sign_out @user

    get root_url
    assert_redirected_to new_user_session_path
  end

  test 'client user can access new action' do
    get new_client_post_path
    assert_response :success
  end

  test "freelancer can't access new action for post" do
    @user.remove_role :client
    @user.add_role :freelancer

    assert_raises(Pundit::NotAuthorizedError){get new_client_post_path}
  end

  test 'create a post' do
    assert_difference('Post.count') do
      post client_posts_path, params: {post: {title: @post.title, months: @post.months, experience: @post.experience, hourly_rate: @post.hourly_rate, project_budget: @post.project_budget, description: @post.description, status: @post.status, skill_list: 'c , java'}}
    end
    assert_redirected_to client_posts_path
    assert_equal 'created post successfully', flash[:notice]
  end

  test "can't create post with invalid data" do
    assert_no_difference('Post.count') do
      post client_posts_path, params: {post: {skill_list: 'c, java'}}
    end
  end

  test 'should edit post' do
    get edit_client_post_path(@post)
    assert_response :success
  end

  test 'update post' do
    post = posts(:post_one)
    patch client_post_path(post), params: {post: {title: 'changed', skill_list: 'c, java'}}
    post.reload
    assert_equal 'changed', post.title
    assert_redirected_to client_posts_path
  end

  test "shouldn't update the product with invalid data" do
    post = posts(:post_one)
    patch client_post_path(post), params: {post: {description: 'invalid description'}}
    post.reload
    assert_not_equal 'invalid description', post.description
    assert_equal 'the post has not been edited!', flash.now[:alert]
  end

  test 'should destroy the product' do
    assert_difference('Post.count', -1) do
      delete client_post_path(@post)
    end
    assert_redirected_to client_posts_path
  end
end