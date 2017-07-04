require("test_helper")

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category = Category.create(name: "sports")
  end

  test "should get categories index" do
    get :index
    assert_response :success
  end

  test "should get category's new" do
    get :new
    assert_response :success
  end

  test "should get category show" do 
    get :show, params: {"id" => @category.id}
    assert_response :success
  end

  test "should update category name" do
    put :update, params: {"id" => @category.id, :category => {:name => "sport1"}}
    assert_equal "sport1", @category.reload.name
    assert_redirected_to category_path(@category.id)
  end

  test "should destroy category" do
    delete :destroy, params: {"id" => @category.id}
    assert_not Category.exists?(@category.id)
    assert_redirected_to categories_path
  end
    
end