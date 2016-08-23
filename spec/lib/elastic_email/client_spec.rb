require 'spec_helper'
require 'elastic_email/client'

describe ElasticEmail::Client do

  let(:client) { ElasticEmail::Client.new }
  let(:params) { {'api_key'=>'API-KEY', 'username'=>'username@test.com'} }

  describe '#send_message' do
    it 'should make a POST rest request passing the parameters to the Elastic Email end point' do
      # mock request
      stub_request(:post, client.elastic_email_send_url).
          with(:body => params,
               :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                            'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'api.elasticemail.com',
                            'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => 'abc12345-a123-b123-c123-000000000000', :headers => {})

      response = client.send_message(params)
      expect(response.is_a?(Net::HTTPResponse)).to be true
    end
  end
end
