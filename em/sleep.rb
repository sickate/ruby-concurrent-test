class Sleep < Cramp::Action
  def start
    t0 = Time.now
    puts "Start at #{t0}!"
    EM.add_timer(0.2) { 
      t1 = Time.now
      puts "Slept for #{t1 -t0} seconds!"
      render "Slept for #{t1 -t0} seconds!"
      finish
    }
  end
end
