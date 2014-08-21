module G5
  module Logger
    class Log
      Levels = {
          emergency: 0,
          fatal:     0,
          alert:     1,
          critical:  2,
          error:     3,
          warn:      4,
          notice:    5,
          info:      6,
          debug:     7,
          devel:     7,
      }

      class << self
        def create_req_resp_log(attributes)

        end

        Levels.each_pair do |name, level|
          define_method(name) do |attributes|
            log({level: level}.merge(attributes))
          end
        end

        def log(attributes)

        end
      end
    end
  end
end