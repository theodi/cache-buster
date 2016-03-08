require 'spec_helper'

module CacheBuster
  describe Pi do

    before(:each) do
      expect(PiPiper::Pin).to receive(:new) {
        pin = instance_double(PiPiper::Pin)
        expect(pin).to receive(:on)
        expect(pin).to receive(:off)
        expect(pin).to receive(:release)
        pin
      }.at_least(2).times

      allow_any_instance_of(Kernel).to receive(:sleep) { nil }
    end

    it 'should do a soft reset when the soft button is pressed' do
      expect(CacheBuster::Cloudflare).to receive(:new) {
        double = instance_double(CacheBuster::Cloudflare)
        expect(double).to receive(:clear)
        double
      }

      expect(PiPiper).to receive(:watch).with(pin: ENV['SOFT_BUTTON'].to_i).and_yield

      expect { described_class.new }.to raise_error(SystemExit)
    end

    it 'should do a hard reset when the hard button is pressed' do
      expect(CacheBuster::Rackspace).to receive(:new) {
        double = instance_double(CacheBuster::Rackspace)
        expect(double).to receive(:clear)
        double
      }

      expect(PiPiper).to receive(:watch).with(pin: ENV['SOFT_BUTTON'].to_i)
      expect(PiPiper).to receive(:watch).with(pin: ENV['HARD_BUTTON'].to_i).and_yield

      expect { described_class.new }.to raise_error(SystemExit)
    end

  end
end
