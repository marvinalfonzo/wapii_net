require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get posts" do
    get users_posts_url
    assert_response :success
  end

  test "should get comments" do
    get users_comments_url
    assert_response :success
  end

end
