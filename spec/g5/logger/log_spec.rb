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

  describe :log do
    let(:params) do
      {source_name:                 'test',
       level:                       3,
       external_parent_id:          33,
       external_parent_source_name: 'g5-jobs',
       title:                       'test title',
       message:                     'a big error occurred'}
    end
    subject do
      VCR.use_cassette('logging') do
        G5::Logger::Log.log(params)
      end
    end
    its(:code) { is_expected.to eq(201) }
  end
end
