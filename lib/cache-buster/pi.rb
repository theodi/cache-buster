module CacheBuster
  class Pi

    def initialize
      watch_buttons
    end

    def watch_buttons
      PiPiper.after pin: ENV['SOFT_BUTTON'].to_i, direction: :in, pull: :down, goes: :high do
        CacheBuster::Pi.soft
      end

      PiPiper.after pin: ENV['HARD_BUTTON'].to_i, direction: :in, pull: :down, goes: :high do
        CacheBuster::Pi.hard
      end

      PiPiper.wait
    end

    def self.hard
      run Proc.new { Rackspace.new.clear }
      sleep 30
    end

    def self.soft
      run Proc.new { Cloudflare.new.clear }
      sleep 30
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
