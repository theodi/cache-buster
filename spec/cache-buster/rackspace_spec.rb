require 'spec_helper'

module CacheBuster
  describe Rackspace, :vcr do

    ENV['RACKSPACE_SERVER_IDS'] = 'a,b,c'

    let(:rackspace) { described_class.new }
    let(:connection) { rackspace.instance_variable_get("@connection") }

    it 'sets up a connection' do
      expect(connection.class).to eq(Fog::Compute::RackspaceV2::Real)
      expect(connection.instance_variable_get "@rackspace_username").to eq(ENV['RACKSPACE_USERNAME'])
      expect(connection.instance_variable_get "@rackspace_api_key").to eq(ENV['RACKSPACE_API_KEY'])
    end

    it 'gets server ids as an array' do
      expect(rackspace.servers).to eq(['a','b','c'])
    end

    it 'reboots each server and waits' do
      expect(connection).to receive(:reboot_server).with('a', 'SOFT')
      expect(connection).to receive(:reboot_server).with('b', 'SOFT')
      expect(connection).to receive(:reboot_server).with('c', 'SOFT')
      expect_any_instance_of(Kernel).to receive(:sleep).exactly(3).times.with(90) { nil }
      rackspace.clear
    end

  end
end
