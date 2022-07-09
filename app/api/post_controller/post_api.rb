module PostController
  class PostApi < BaseApi

    resource 'posts' do

      # POST /api/v1/posts
      get '' do
        total = Post.count
        records = Post.limit(params[:limit]).offset(0)

        {
          total: total,
          records: records,
        }
      end

      post '' do
        attrs = {
          title: params[:title],
          content: params[:content],
          user_id: nil,
          thumb_nail_image_src: params[:image_src],
        }
        post = Post.create(attrs)
        post
      end
    end # resource 'posts'
  end # class
end # module