class Sheep
  def initialize
    @shorn = false
  end

  def shorn?
    @shorn
  end

  def shear!
    puts "shearing..."
    @shorn = true
  end
end

# following code is not thread safe

#sheep = Sheep.new

#5.times.map do
  #Thread.new do
    #unless sheep.shorn?
      #sheep.shear!
    #end
  #end
#end.each(&:join)


sheep = Sheep.new
sheep_queue = Queue.new
sheep_queue << sheep

5.times.map do
  Thread.new do
      begin
        sheep = sheep_queue.pop(true)

        sheep.shear!
      rescue ThreadError
        # raised by Queue#pop in the threads
        # that don't pop the sheep
      end
  end
end.each(&:join)
