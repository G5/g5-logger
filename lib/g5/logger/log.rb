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
        Levels.each_pair do |name, level|
          define_method(name) do |attributes|
            log({level: level}.merge(attributes))
          end
        end

        def log(attributes)
          default_merge = {source_name: Config[:source_name]}.merge(attributes)
          result        = Typhoeus.post(Config[:logging_service_endpoint], body: {log: default_merge}.to_json, headers: {'content-type' => 'application/json', Accept: 'application/json'})
          puts "error in posting log status: #{result.code} body: #{result.body}" unless 201 == result.code
          result
        end
      end
    end
  end
end