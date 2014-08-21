require 'g5/logger/version'
require 'g5/logger/log'
require 'typhoeus'

module G5
  module Logger
    # override in your Rails.root/config/initializers
    Config = {
        logging_service_endpoint: 'REQUIRED'
    }
  end
end
