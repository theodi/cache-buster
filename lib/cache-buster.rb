require "dotenv"
require "rubyflare"
require "fog/rackspace"
require "thor"

Dotenv.load

require "cache-buster/version"
require "cache-buster/cloudflare"
require "cache-buster/rackspace"
require "cache-buster/cli"

module CacheBuster
end
