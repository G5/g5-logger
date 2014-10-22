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
          default_merge = {source_app_name: Config[:source_app_name]}.merge(attributes)
          log_level     = level(default_merge.delete(:level))
          Config[:logger].send(log_level, log_entry(default_merge))
        end

        def level(level)
          Levels.include?(level) ? level : :info
        end

        def log_entry(hash)
          if  G5::Logger::KEY_VALUE_FORMAT== G5::Logger::Config[:format]
            hash.keys.collect { |key| "#{key}=\"#{hash[key]}\"" }.join(", ")
          else
            hash.to_json
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
      end
    end
  end
end