require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :once }
  c.allow_http_connections_when_no_cassette = false

  c.filter_sensitive_data('<CLOUDFLARE_API_KEY>') { ENV['CLOUDFLARE_API_KEY'] }
  c.filter_sensitive_data('<CLOUDFLARE_EMAIL>') { ENV['CLOUDFLARE_EMAIL'] }
  c.filter_sensitive_data('<CLOUDFLARE_ZONE_ID>') { ENV['CLOUDFLARE_ZONE_ID'] }
  c.filter_sensitive_data('<RACKSPACE_USERNAME>') { ENV['RACKSPACE_USERNAME'] }
  c.filter_sensitive_data('<RACKSPACE_API_KEY>') { ENV['RACKSPACE_API_KEY'] }

  c.configure_rspec_metadata!
end
