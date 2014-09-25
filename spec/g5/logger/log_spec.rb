require 'spec_helper'

describe G5::Logger::Log do
  describe 'levels' do
    G5::Logger::Log::Levels.each do |method|
      it "delegates #{method} to log method" do
        expect(TestLogger).to receive(method).with("source_app_name=\"test\", foo=\"bar\"")
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
       title:                       'attachments title',
       request:                     '<request></request>',
       response:                    {foo: 'bar'}.to_json
      }
    end
    subject do
      G5::Logger::Log.log(params)
      TestLogger.last_payload
    end
    it { is_expected.to eq("source_app_name=\"test\", source_name=\"test\", external_parent_id=\"33\", external_parent_source_name=\"g5-jobs\", title=\"attachments title\", request=\"<request></request>\", response=\"{\"foo\":\"bar\"}\"") }
  end
end
