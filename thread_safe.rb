# In MRI it will return 5000
# In Jruby or Rubinius, it will return less than 5000
# Array is not thread saft by default..
require 'thread'

array = []

t0=Time.now
5.times.map do
  Thread.new do
    1000.times do
      array << nil
    end
  end
end.each(&:join)

puts array.size
puts Time.now - t0


# now we are using Mutex
semaphore = Mutex.new

safe_array = []

t1=Time.now
1000.times.map do
  Thread.new do
    semaphore.synchronize {
      5.times do
        safe_array << nil
      end
    }
  end
end.each(&:join)

puts safe_array.size
puts Time.now - t1

# NOTE: Mutex should be out of `1000.times` loop, or it will raise mutex error
# 
# Thread.new do
#    1000.times do
#      semaphore.synchronize {
#        safe_array << nil
#      }
#    end
#  end

# this will raise (with odds):
#
# In Jruby:
# ConcurrencyError: Detected invalid array contents due to unsynchronized modifications with concurrent users
#
# In Rbx:
# Tuple::copy_from: index 2681 out of bounds for size 2398 (Rubinius::ObjectBoundsExceededError))


# Result
# Jruby
# ruby thread-safe.rb
# 4931
# 0.028
# 5000
# 0.043

# Rbx
# 3543
# 0.0011229999999999999
# 5000
# 0.040255

# Ruby 2.2.0
# 5000
# 0.000791
# 5000
# 0.001396

# Ruby 1.9.3-p551
# 5000
# 0.0018
# 5000
# 0.001226

# Rubinius got better thread switching perf than 1.9.3, but not as good as 2.2.0, Jruby worst
# Mutex slows down Rbx a lot

