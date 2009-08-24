require 'test_helper'

class FeedControllerTest < ActionController::TestCase

  fixtures :feed_items

  test "get index" do
    get :index
    assert_response :success
    assert_template :index
    assert_equal 2, assigns(:feeds).length
    assert_select "li", 2
  end

 test "get index RSS" do
    get :index, :format => "rss"
    assert_response :success
    assert_equal 2, assigns(:feeds).length
    assert_select "item", 2
  end

  test "get feed one" do
    get :show, :feed_name => "feed_one"
    assert_response :success
    assert_equal 3, assigns(:feed_items).length
    assert_select "dl", 1
    assert_select "dt", 3
    assert_select "dd", 3
  end

  test "get feed one RSS" do
    get :show, :feed_name => "feed_one", :format => "rss"
    assert_response :success
    assert_equal 3, assigns(:feed_items).length
    assert_select "rss", 1
    assert_select "rss > channel", 1
    assert_select "rss > channel > title", 1
    assert_select "item", 3
    assert_select "item > title ", 3
    assert_select "rss > channel > item", 3
    assert_select "rss > channel > item > title ", 3
  end

  test "get feed two" do
    get :show, :feed_name => "feed_two"
    assert_response :success
    assert_equal 2, assigns(:feed_items).length
    assert_select "dl", 1
    assert_select "dt", 2
    assert_select "dd", 2
  end

  test "add item to feed one" do
    post :update, :feed_name => "feed_one", :title => "extra item", :description => "some description"
    assert_response :redirect

    get :show, :feed_name => "feed_one"
    assert_response :success
    assert_equal 4, assigns(:feed_items).length
    assert_select "dl", 1
    assert_select "dt", 4
    assert_select "dd", 4
    assert_tag :tag => "dt", :content => "extra item",
      :before => {:tag => "dd", :content => "some description"}

    get :show, :feed_name => "feed_two"
    assert_response :success
    assert_equal 2, assigns(:feed_items).length
  end

  test "alter item in feed one" do
    get :show, :feed_name => "feed_one"
    assert_response :success
    assert_equal 3, assigns(:feed_items).length
    assert_select "dl", 1
    assert_select "dt", 3
    assert_select "dd", 3
    assert_tag :tag => "dt", :content => "feed one item two",
      :before => {:tag => "dd", :content => "feed one item two description"}

    post :update, :feed_name => "feed_one",
      :title => "feed one item two",
      :description => "some description"
    assert_response :redirect

    get :show, :feed_name => "feed_one"
    assert_response :success
    assert_equal 3, assigns(:feed_items).length
    assert_select "dl", 1
    assert_select "dt", 3
    assert_select "dd", 3
    assert_tag :tag => "dt", :content => "feed one item two",
      :before => {:tag => "dd", :content => "some description"}

    get :show, :feed_name => "feed_two"
    assert_response :success
    assert_equal 2, assigns(:feed_items).length
  end

  test "delete item in feed one" do
    get :show, :feed_name => "feed_one"
    assert_response :success
    assert_equal 3, assigns(:feed_items).length
    assert_select "dl", 1
    assert_select "dt", 3
    assert_select "dd", 3
    assert_tag :tag => "dt", :content => "feed one item two",
      :before => {:tag => "dd", :content => "feed one item two description"}

    post :update, :feed_name => "feed_one",
      :title => "feed one item two",
      :description => ""
    assert_response :redirect

    get :show, :feed_name => "feed_one"
    assert_response :success
    assert_equal 2, assigns(:feed_items).length
    assert_select "dl", 1
    assert_select "dt", 2
    assert_select "dd", 2
    assert_no_tag :tag => "dt", :content => "feed one item two"

    get :show, :feed_name => "feed_two"
    assert_response :success
    assert_equal 2, assigns(:feed_items).length
  end

  test "create feed three" do
    get :index
    assert_response :success
    assert_template :index
    assert_equal 2, assigns(:feeds).length
    assert_select "li", 2

    post :update, :feed_name => "feed_three",
      :title => "feed three item one",
      :description => "feed three item one description"
    assert_response :redirect

    get :index
    assert_response :success
    assert_template :index
    assert_equal 3, assigns(:feeds).length
    assert_select "li", 3

    get :show, :feed_name => "feed_three"
    assert_response :success
    assert_equal 1, assigns(:feed_items).length
    assert_select "dl", 1
    assert_select "dt", 1
    assert_select "dd", 1
    assert_tag :tag => "dt", :content => "feed three item one",
      :before => {:tag => "dd", :content => "feed three item one description"}

    get :show, :feed_name => "feed_one"
    assert_response :success
    assert_equal 3, assigns(:feed_items).length

    get :show, :feed_name => "feed_two"
    assert_response :success
    assert_equal 2, assigns(:feed_items).length
  end

end
