require 'spec_helper'

module CacheBuster
  describe Pi do

    before(:each) do
      expect(PiPiper::Pin).to receive(:new).with(pin: ENV['RED_PIN'], direction: :out) do
        @red_pin = instance_double(PiPiper::Pin)
        expect(@red_pin).to receive(:on)
        expect(@red_pin).to receive(:off)
        @red_pin
      end

      expect(PiPiper::Pin).to receive(:new).with(pin: ENV['GREEN_PIN'], direction: :out) do
        @green_pin = instance_double(PiPiper::Pin)
        expect(@green_pin).to receive(:on)
        expect(@green_pin).to receive(:off)
        @green_pin
      end

      allow_any_instance_of(Kernel).to receive(:sleep) { nil }
    end

    it 'should do a soft reset when the soft button is pressed' do
      expect(CacheBuster::Cloudflare).to receive(:new) {
        double = instance_double(CacheBuster::Cloudflare)
        expect(double).to receive(:clear)
        double
      }

      expect(PiPiper).to receive(:watch).with(pin: ENV['SOFT_BUTTON']).and_yield

      expect { described_class.new }.to raise_error(SystemExit)
    end

    it 'should do a hard reset when the hard button is pressed' do
      expect(CacheBuster::Rackspace).to receive(:new) {
        double = instance_double(CacheBuster::Rackspace)
        expect(double).to receive(:clear)
        double
      }

      expect(PiPiper).to receive(:watch).with(pin: ENV['SOFT_BUTTON'])
      expect(PiPiper).to receive(:watch).with(pin: ENV['HARD_BUTTON']).and_yield

      expect { described_class.new }.to raise_error(SystemExit)
    end

  end
end
