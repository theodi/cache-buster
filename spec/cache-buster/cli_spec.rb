require 'spec_helper'

module CacheBuster
  describe Cli do

    before(:each) do
      @cli = CacheBuster::Cli.new
      allow(@cli).to receive(:say) { nil }
    end

    it 'clears the cache for a particular page' do
      expect(CacheBuster::Cloudflare).to receive(:new) {
        double = instance_double(CacheBuster::Cloudflare)
        expect(double).to receive(:clear).with('foo')
        double
      }

      @cli.clear('foo')
    end

    it 'clears the cache for news by default' do
      expect(CacheBuster::Cloudflare).to receive(:new) {
        double = instance_double(CacheBuster::Cloudflare)
        expect(double).to receive(:clear).with('news')
        double
      }

      @cli.clear
    end

    it 'does a hard cache clear' do
      expect(CacheBuster::Rackspace).to receive(:new) {
        double = instance_double(CacheBuster::Rackspace)
        expect(double).to receive(:clear)
        double
      }

      allow(@cli).to receive(:yes?) { true }
      allow_any_instance_of(Kernel).to receive(:sleep) { nil }

      @cli.options = { hard: true }
      @cli.clear
    end

    it 'aborts if the user says no' do
      expect(CacheBuster::Rackspace).to_not receive(:new)

      expect(@cli).to receive(:say).with("\nAborting. This was probably the right decision.\n", :green)

      allow(@cli).to receive(:yes?) { false }
      @cli.options = { hard: true }
      @cli.clear
    end

  end
end
