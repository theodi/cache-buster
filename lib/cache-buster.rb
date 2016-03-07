require "dotenv"
require "rubyflare"
require "fog/rackspace"

Dotenv.load

require "cache-buster/version"
require "cache-buster/cloudflare"
require "cache-buster/rackspace"

module CacheBuster
end
