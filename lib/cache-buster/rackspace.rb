module CacheBuster
  class Rackspace

    def initialize
      @connection = Fog::Compute.new(
        :provider           => 'Rackspace',
        :rackspace_api_key  => ENV['RACKSPACE_API_KEY'],
        :rackspace_username => ENV['RACKSPACE_USERNAME'],
        :rackspace_region   => :lon
      )
    end

    def clear
      servers.each do |server_id|
        @connection.reboot_server(server_id, 'SOFT')
        sleep 90
      end
    end

    def servers
      ENV['RACKSPACE_SERVER_IDS'].split(',')
    end

  end
end
