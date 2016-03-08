module CacheBuster
  class Pi

    def initialize
      @red = PiPiper::Pin.new(pin: ENV['RED_PIN'], direction: :out)
      @green = PiPiper::Pin.new(pin: ENV['GREEN_PIN'], direction: :out)
      watch
    end

    def watch
      PiPiper.watch pin: ENV['SOFT_BUTTON'] { soft }
      PiPiper.watch pin: ENV['HARD_BUTTON'] { hard }
      PiPiper.wait
    end

    def hard
      run Proc.new { Rackspace.new.clear }
    end

    def soft
      run Proc.new { Cloudflare.new.clear }
    end

    def run(proc)
      @red.on
      proc.call
      @red.off
      @green.on
      sleep 5
      @green.off
      exit if ENV['TEST']
    end

  end
end
