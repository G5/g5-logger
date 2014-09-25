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
          log_entry     = default_merge.keys.collect { |key| "#{key}=\"#{default_merge[key]}\"" }.join(", ")
          Config[:logger].send(log_level, log_entry)
        end

        def level(level)
          Levels.include?(level) ? level : :info
        end
      end
    end
  end
end