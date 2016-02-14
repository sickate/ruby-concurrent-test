class SqlSleep < Cramp::Action
  def start
    t0 = Time.now
    sec = 0.1 

    sql = "select pg_sleep(#{sec})"
    ActiveRecord::Base.connection.execute(sql)

    t1 = Time.now
    render "Sql slept for #{t1 -t0} seconds!"
    finish
  end
end
