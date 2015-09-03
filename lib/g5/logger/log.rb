module G5
  module Logger
    class Log
      Levels = %w(debug info warn error fatal unknown)

      class << self
        Levels.each do |name|
          define_method(name) do |attributes|
            log({level: name}.merge(attributes))
          end
        end

        def log(attributes)
          default_merge = {source_app_name: Config[:source_app_name]}.merge(Config[:default_log_hash]).merge(attributes)
          log_level     = level(default_merge.delete(:level))
          Config[:logger].send(log_level, log_entry(default_merge))
        end

        def level(level)
          Levels.include?(level) ? level : :info
        end

        def log_entry(hash)
          scrubbed = redact hash.clone
          if  G5::Logger::KEY_VALUE_FORMAT== G5::Logger::Config[:format]
            scrubbed.keys.collect do |key|
              value = hash[key]
              value.scrub!("?") if value.respond_to?(:scrub)
              "#{key}=\"#{value}\""
            end.join(", ")
          else
            scrubbed.to_json
          end
        end

        def log_json_req_resp(request, response, options={})
          options = options.merge(
              status:   response.try(:code),
              request:  request,
              response: response.try(:body))

          send(log_method(response.code), options)
        end

        def log_method(code)
          error = code > 299 rescue false
          error ? :error : :info
        end

        def redact(hash)
          hash.keys.each do |key|
            redact(hash[key]) if hash[key].kind_of?(Hash)
            redact_array(hash[key]) if hash[key].kind_of?(Array)
            hash[key] = Config[:redact_value] if redactable?(key)
          end
          hash
        end

        def redactable?(value)
          return false if value.blank? || ![String, Symbol].include?(value.class)
          !!Config[:redact_keys].detect { |rk|
            if rk.class == String
              rk == value
            else
              value.match(rk)
            end
          }
        end

        def redact_array(array)
          array.each do |array_val|
            redact array_val if array_val.kind_of?(Hash)
          end
        end
      end
    end
  end
end
