module CacheBuster
  class Pi

    def initialize
      watch_buttons
    end

    def watch_buttons
      PiPiper.watch pin: ENV['SOFT_BUTTON'].to_i do
        CacheBuster::Pi.soft
      end

      PiPiper.watch pin: ENV['HARD_BUTTON'].to_i do
        CacheBuster::Pi.hard
      end

      PiPiper.wait
    end

    def self.hard
      run Proc.new { Rackspace.new.clear }
    end

    def self.soft
      run Proc.new { Cloudflare.new.clear }
    end

    def self.run(proc)
      red = PiPiper::Pin.new(pin: ENV['RED_PIN'].to_i, direction: :out)
      green = PiPiper::Pin.new(pin: ENV['GREEN_PIN'].to_i, direction: :out)
      red.on
      proc.call
      red.off
      green.on
      sleep 5
      green.off
      red.release
      green.release
      exit if ENV['TEST']
    end

  end
end
