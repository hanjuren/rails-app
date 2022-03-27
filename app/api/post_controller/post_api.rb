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
    end # resource 'posts'
  end # class
end # module