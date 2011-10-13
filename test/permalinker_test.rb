# encoding: UTF-8
require 'test/unit'
require 'active_record'
require 'permalinker'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "permalinker.sqlite3")

ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define(:version => 1) do
  create_table :posts, :force => true do |t|
    t.string :title
  end
  
 create_table :articles, :force => true do |t|
   t.string :title
 end
 
 create_table :users, :force => true do |t|
   t.string :name
 end
 
 create_table :blogs, :force => true do |t|
 end
end

ActiveRecord::Migration.verbose = true

class Post < ActiveRecord::Base
  permalink do
    title.parameterize
  end
end

class Article < ActiveRecord::Base
  permalink :lolwut
  
  def lolwut
    title.parameterize
  end
end

class User < ActiveRecord::Base
  def to_param
    name.parameterize
  end
end

class Blog < ActiveRecord::Base
end

class PermalinkTest < Test::Unit::TestCase
  
  def test_post
    @post = Post.create(:title => 'New Post')
    assert_respond_to @post, :with_permalink
    assert_respond_to @post, :without_permalink
    assert_equal @post.with_permalink.to_param, 'new-post'
    assert_equal @post.without_permalink.to_param, @post.id.to_s
    assert_equal @post.to_param, @post.id.to_s
  end
  
  def test_article
    @article = Article.create(:title => 'New Post')
    assert_respond_to @article, :with_permalink
    assert_respond_to @article, :without_permalink
    assert_equal @article.with_permalink.to_param, 'new-post'
    assert_equal @article.without_permalink.to_param, @article.id.to_s
    assert_equal @article.with_permalink.without_permalink.to_param, @article.id.to_s
    assert_equal @article.to_param, @article.id.to_s
  end
  
  def test_user
    @user = User.create(:name => 'Vasya Poupkine')
    assert_respond_to @user, :without_permalink
    assert !@user.respond_to?(:with_permalink)
    assert_equal @user.to_param, 'vasya-poupkine'
    assert_equal @user.without_permalink.to_param, @user.id.to_s
  end
  
  def test_blog
    assert_raise Permalinker::NoPermalinkMethod do
      Blog.permalink
    end
  end
end