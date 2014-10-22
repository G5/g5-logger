require 'g5/logger'
require 'pry'
require 'rspec/its'

ROOTPATH = File.expand_path('..', __FILE__)
Dir[File.join(ROOTPATH, 'support/**/*.rb')].each { |support| require support }
G5::Logger::Config[:logger]          = TestLogger
G5::Logger::Config[:source_app_name] = 'test'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

def indifferent_hash_from_json(json)
  ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(json))
end

