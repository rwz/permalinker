Helpers for permalinking in Rails 3.

Examples:

    # model
    class User < ActiveRecord::Base
      def to_param
        name.parameterize
      end
    end
    
    # view
    user_url(@user) => '/users/david-heinemeier-hansson'
    admin_user_url(@user.without_permalink) => '/admin/users/1'
    
    # model
    class BlogPost < ActiveRecord::Base
      permalink do
        [ created_at.strftime('%Y/%m/%d'), title.parameterize ] * '/'
      end
    end
    
    # view
    blog_post_url(@blog_post) => '/blog_posts/1'
    blog_post_url(@blog_post.with_permalink) => '/blog_posts/2011/10/13/cool-blog-post-title-goes-here'