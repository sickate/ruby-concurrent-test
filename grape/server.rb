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


    desc ' db.'
    get :sql_sleep do
      t0 = Time.now
      sec = 0.2
      sql = "select pg_sleep(#{sec})"
      ActiveRecord::Base.connection.execute(sql)
      t1 = Time.now

      puts "SQL_SLEEP Start at #{t0}, cost #{t1 - t0} seconds!"
      if t1 - t0 > 3
        puts "SLEEP SLOWREQUEST}"
      elsif t1 - t0 < 0.02
        puts "SLEEP FASTREQUEST"
      end
      "I slept for #{sec} sec."
    end

    desc 'Test db.'
    get :sql do
      t0 = Time.now
      post = Post.create(title: "I dream of #{rand(10000)} elephants.",
                         content: 'lalallalallallal')
      t1 = Time.now
      puts "Start at #{t0}, cost #{t1 - t0} seconds! Object id is: #{post.id}..."
      if t1 - t0 > 3
        puts "SQL SLOWREQUEST #{}"
      elsif t1 - t0 < 0.02
        puts "SQL FASTREQUEST"
      end
      "Post created! Content: #{post.to_json}."
    end
  end
end
