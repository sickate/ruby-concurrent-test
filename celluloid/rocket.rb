require 'celluloid'

class Rocket
  include Celluloid

  def launch
    raise 'Huston we have a problem'
    3.downto(1) do |n|
      puts "#{n}..."
      sleep 1
    end
    puts "Blast off!"
  end

  trap_exit :recover

  def recover(actor, reason)
    puts "recovers!"
  end
end
