require("test_helper")

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username:"Paul", email:"dsa@sa.net", password:"dòsadaff", admin:true);
  end

  test "should get categories index" do
    get :index
    assert_response :success
  end

  test "should get category's new" do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end

  test "should get category show" do 
    get :show, params: {"id" => @category.id}
    assert_response :success
  end

  test "should update category name" do
    session[:user_id] = @user.id
    put :update, params: {"id" => @category.id, :category => {:name => "sport1"}}
    assert_equal "sport1", @category.reload.name
    assert_redirected_to category_path(@category.id)
  end

  test "should destroy category" do
    session[:user_id] = @user.id
    delete :destroy, params: {"id" => @category.id}
    assert_not Category.exists?(@category.id)
    assert_redirected_to categories_path
  end

  test "should redirect to create if admin not logged in" do
    assert_no_difference "Category.count" do 
      post :create, params: {category: { name: "sports" }}
    end
      assert_redirected_to categories_path
  end

  private 
  def set_admin
    session[:user_id] = @user.id
  end
    
    
end