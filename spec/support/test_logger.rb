class TestLogger
  Levels = [
      :debug, :info, :warn, :error, :fatal, :unknown
  ]

  class << self
    Levels.each do |name|
      define_method(name) do |payload|
        @@last_payload = payload
        @@last_level   = name
      end
    end

    def last_payload
      @@last_payload
    end

    def last_level
      @@last_level
    end
  end
end
