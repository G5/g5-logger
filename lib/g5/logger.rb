require 'g5/logger/version'
require 'g5/logger/log'
require 'active_support/core_ext'

module G5
  module Logger
    KEY_VALUE_FORMAT = 'key_value'
    JSON_FORMAT      = 'json'
    # override in your Rails.root/config/initializers
    Config           = {
        logger:          'REQUIRED', #usually Rails.logger
        source_app_name: 'REQUIRED - this is the name of the app using it',
        format:          JSON_FORMAT # json or key_value
    }
  end
end
