require 'g5/logger'
require 'pry'
require 'rspec/its'
require 'vcr'

ROOTPATH = File.expand_path('..', __FILE__)
Dir[File.join(ROOTPATH, 'support/**/*.rb')].each { |support| require support }
G5::Logger::Config[:logging_service_endpoint] = 'http://localhost:5781/api/v1/logs'

RSpec.configure do |config|
  config.run_all_when_everything_filtered                = true
  config.filter_run :focus
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
end
