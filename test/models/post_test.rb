require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @post = posts(:post_one)
  end

  test 'test the presence of attributes' do
    attribute_values = @post.attributes.values_at("title", 'months', 'hourly_rate', 'experience', 'description', 'user_id')
    assert_not_includes(attribute_values, nil)
  end

  test "minimum value of months can't be equal to or greater than maximum value" do
    assert_not @post.months[0] >= @post.months[1]
  end

  test "minimum value of hourly rate can't be equal to or greater than hourly rate" do
    assert_not @post.months[0] >= @post.months[1]
  end

  test 'error message of post for months' do
    @post.update(months: ['5', '4'])
    assert_equal("minimum value can't be equal to or greater than maximum value", @post.errors[:months][0])
  end

  test 'error message of post for hourly rate' do
    @post.update(hourly_rate: ['6', '5'])
    assert_equal("minimum value can't be equal to or greater than maximum value", @post.errors[:hourly_rate][0])
  end
end
