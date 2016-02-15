class SqlSelect < Cramp::Action
  def start
    t0 = Time.now

    post = Post.where(id: rand(100000)).first

    t1 = Time.now

    if post
      puts "Selected object id is: #{post.id}, ran for #{t1 - t0} seconds!"
      render "Posted object id is: #{post.id}, ran for #{t1 - t0} seconds!"
    else
      puts "foundnoposts, ran for #{t1 - t0} seconds!"
      render "foundnoposts, ran for #{t1 - t0} seconds!"
    end
    finish
  end
end
