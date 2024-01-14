require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:user_one)
  end

  test 'test the presence of attributes' do
    attribute_values = @user.attributes.values_at("first_name", 'last_name', 'policy')
    assert_not_includes(attribute_values, nil)
  end

  test 'user has many posts' do
    assert_not_nil posts(:post_one).user
  end

  test 'posts are deleted when user is also deleted' do
    @user.destroy
    assert_raises(ActiveRecord::RecordNotFound){posts(:post_one)}
  end

  test 'can add roles to user' do
    @user.add_role :client
    assert @user.has_role? :client
  end
end
