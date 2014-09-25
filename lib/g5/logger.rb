require 'g5/logger/version'
require 'g5/logger/log'
require 'active_support/core_ext'

module G5
  module Logger
    # override in your Rails.root/config/initializers
    Config = {
        logger:          'REQUIRED', #usually Rails.logger
        source_app_name: 'REQUIRED - this is the name of the app using it'
    }
  end
end
