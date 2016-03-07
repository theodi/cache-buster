require 'spec_helper'

module CacheBuster
  describe Cloudflare, :vcr do

    let (:cloudflare) { described_class.new }
    let (:connection) { cloudflare.instance_variable_get("@connection") }

    it 'sets a connection on initialization' do
      expect(connection.class).to eq(Rubyflare::Connect)
      expect(connection.instance_variable_get "@api_key").to eq(ENV['CLOUDFLARE_API_KEY'])
      expect(connection.instance_variable_get "@email").to eq(ENV['CLOUDFLARE_EMAIL'])
    end

    it 'gets a zone' do
      zone = cloudflare.zone
      expect(zone[:id]).to eq('632cc8c49a4b54d07639032358d906aa')
      expect(zone[:host]).to eq('http://theodi.org')
    end

    it 'clears the news cache' do
      expect(connection).to receive(:delete).with("/zones/632cc8c49a4b54d07639032358d906aa/purge_cache", {
        files: ["http://theodi.org/news"]
      })
      cloudflare.clear
    end

    it 'clears the cache for an arbitary page' do
      expect(connection).to receive(:delete).with("/zones/632cc8c49a4b54d07639032358d906aa/purge_cache", {
        files: ["http://theodi.org/labs"]
      })
      cloudflare.clear('labs')
    end

  end
end
