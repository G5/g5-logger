require 'g5/logger/version'
require 'g5/logger/log'
require 'active_support'
require 'active_support/core_ext'

module G5
  module Logger
    KEY_VALUE_FORMAT = 'key_value'
    JSON_FORMAT      = 'json'
    # override in your Rails.root/config/initializers
    Config           = {
        logger:          'REQUIRED', #usually Rails.logger
        source_app_name: 'REQUIRED - this is the name of the app using it',
        format:          JSON_FORMAT, # json or key_value
        redact_keys:     [
                            /credit/,
                            /password/,
                            /cvv/,
                            /ssn/,
                            /birth/,
                            /drivers/,
                            /salary/,
                            /content/,
                            /message/,
                            /comment/,
                            /note/,
                            /tel/,
                            /phone/,
                            /address/,
                            /email/,
                            /card/,
                            /amount/,
                         ],
        redact_value:    '***',
        default_log_hash: {} #when you Log.log(your_hash), your_hash will get merged into the default_log_hash
    }
  end
end
