class Sleep < Cramp::Action
  def start
    t0 = Time.now
    sleep 1
    t1 = Time.now
    render "Slept for #{t1 -t0} seconds!"
    finish
  end
end
