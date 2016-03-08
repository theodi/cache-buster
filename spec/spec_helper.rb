require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'helpers/vcr'

ENV['TEST'] = 'true'

require 'cache-buster'
