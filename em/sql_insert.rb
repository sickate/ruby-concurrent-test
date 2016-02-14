class SqlInsert < Cramp::Action
  def start
    t0 = Time.now

    post = Post.create(title: "I dream of #{rand(10000)} elephants.",
                       content: 'lalallalallallal')

    t1 = Time.now
    puts "Posted object id is: #{post.id}, ran for #{t1 - t0} seconds!"
    render "Posted object id is: #{post.id}, ran for #{t1 - t0} seconds!"
    finish
  end
end
