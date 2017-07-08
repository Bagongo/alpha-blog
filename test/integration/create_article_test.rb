require ("test_helper")

class CreateArticleTest < ActionDispatch::IntegrationTest

  def setup
    @newuser = User.create(username:"Paul", email:"dsa@sa.net", password:"password", admin:false);
  end

  test "get new article form create new article" do
    sign_in_as @newuser, "password"
    get new_article_path 
    assert_template "articles/new"
    article = Article.create(title:"article creation test", description:"this article was generated to test the article creation process.")
    assert_difference "Article.count", +1 do
      post articles_path params: { article: {title:article.title, description:article.description} }
      follow_redirect!
    end
    get article_path params: {id:article.id}
  end


  test "article creation should fail if new article gets created with empty params" do
    sign_in_as @newuser, "password"
    get new_article_path 
    assert_template "articles/new"
    article = Article.new(title:" ", description:" ")
    assert_no_difference "Article.count" do
      post articles_path params: { article: {title:article.title, description:article.description} }
    end
    assert_template "articles/new"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

end