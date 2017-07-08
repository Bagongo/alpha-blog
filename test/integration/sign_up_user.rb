require ("test_helper")

class SignUpUserTest < ActionDispatch::IntegrationTest

  test "get new user form and create new user" do
    assert_not logged_in?
    get signup_path
    assert_template "users/new"
    assert_difference "User.count", +1 do
      newuser = User.create(username: "someguy", email:"someguy@someprovider.com", password:"pass", admin: "true")
      post users_path, params: { user: {username: newuser.username, email:newuser.email, password:newuser.password, admin:newuser.admin} }
      assert_match session[:user_id], newuser.id
      follow_redirect!
    end
    assert User.find(newuser.id).exists?
    get user_path(newuser.id)
  end 

  test "user creation should fail if user created with empty params" do 
    assert_not logged_in?
    get signup_path
    assert_template "users/new"
    assert_no_difference "User.count" do
      newuser = User.new(username: " ", email:" ", password:" ")
      post users_path, params: { user: {username: newuser.username, email:newuser.email, password:newuser.password}
      follow_redirect!
    end
    assert_not User.find(newuser.id).exists?
    assert_template "users/new"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

end 