require 'spec_helper'

describe G5::Logger::Log do
  describe 'levels' do
    G5::Logger::Log::Levels.each do |method, level_num|
      it "delegates #{method} to log method with level: #{level_num}" do
        expect(G5::Logger::Log).to receive(:log).with(hash_including(level: level_num, foo: 'bar'))
        G5::Logger::Log.send(method, foo: 'bar')
      end
    end
  end
end
