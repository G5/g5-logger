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

  describe :log_json_req_resp do
    let(:request) { 'req' }
    let(:code) { 201 }
    let(:body) { 'body' }
    let(:response) { double(:response, code: code, body: body) }
    subject do
      G5::Logger::Log.log_json_req_resp(request, response, {foo: 'bar'})
      TestLogger.last_payload
    end
    it { is_expected.to eq("source_app_name=\"test\", foo=\"bar\", status=\"201\", request=\"req\", response=\"body\"") }
  end

  describe :log_method do
    [{code: 201, expected: :info}, {code: 300, expected: :error}, {code: nil, expected: :info}].each do |test_hash|
      it "uses #{test_hash[:expected]} when code is #{test_hash[:code]}" do
        expect(G5::Logger::Log.log_method(test_hash[:code])).to eq(test_hash[:expected])
      end
    end
  end
end
