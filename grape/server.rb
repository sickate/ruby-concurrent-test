module Server
  class API < Grape::API
    version 'v1', using: :header, vendor: 'grape_test'
    format :json
    prefix :api

    helpers do
      def current_user
        @current_user ||= User.authorize!(env)
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end

    desc 'Return a public timeline.'
    get :sleep do
      sec = 0.2
      sleep sec
      "I slept for #{sec} sec."
    end

    desc 'Return a public timeline.'
    get :sql do
      post = Post.create(title: "I dream of #{rand(10000)} elephants.",
                         content: 'lalallalallallal')
      puts post.id
      "Post created! Content: #{post.to_json}."
    end
  end
end
