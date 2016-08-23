require 'spec_helper'
require 'elastic_email/deliverer'
require 'elastic_email/client'
require 'elastic_email/error'

describe ElasticEmail::Deliverer do

  let(:deliverer) { ElasticEmail::Deliverer.new({api_key: 'API-KEY', username: 'username@test.com'}) }
  let(:client) { ElasticEmail::Client.new }
  let(:html_body) { '<label>HTML Content</label>' }
  let(:text_body) { 'Text Content' }
  let(:default_message_params) { {to: 'to@test.com', from: 'from@test.com', subject: 'Subject'} }
  let(:rails_message_html) { Mail::Message.new(default_message_params.merge(content_type: 'text/html', body: html_body)) }
  let(:rails_message_text) { Mail::Message.new(default_message_params.merge(content_type: 'text/plain', body: text_body)) }
  let(:default_request_params) do
    {
        'username' => 'username@test.com', 'api_key' => 'API-KEY', 'from' => 'from@test.com',
        'to' => 'to@test.com', 'subject' => 'Subject'
    }
  end
  let(:request_params_html) { default_request_params.merge('body_html'=> html_body) }
  let(:request_params_text) { default_request_params.merge('body_text'=> text_body) }
  let(:successfull_email_id) { 'abc12345-a123-b123-c123-000000000000' }

  context '#deliver!' do

    it 'should return message ID on delivery' do
      mock_request request_params_html, successfull_email_id

      response = deliverer.deliver!(rails_message_html)
      expect(response.is_a?(Net::HTTPResponse)).to be true
      expect(rails_message_html.message_id).to eq successfull_email_id
    end

    it 'should send HTML only messages' do
      mock_request request_params_html, successfull_email_id

      response = deliverer.deliver!(rails_message_html)
      expect(response.is_a?(Net::HTTPResponse)).to be true
    end

    it 'should send text only messages' do
      mock_request request_params_text, successfull_email_id

      response = deliverer.deliver!(rails_message_text)
      expect(response.is_a?(Net::HTTPResponse)).to be true
    end

    it 'should send Reply To when is passed' do
      params = request_params_text.merge('reply_to' => 'replyto@text.com')
      message =  Mail::Message.new(default_message_params.merge(content_type: 'text/plain',
                                                                body: text_body, reply_to: 'replyto@text.com'))
      mock_request params, successfull_email_id

      response = deliverer.deliver!(message)
      expect(response.is_a?(Net::HTTPResponse)).to be true
    end

    it 'should raise an error when the delivery fail' do
      mock_request request_params_html, 'AUTHENTICATION ERROR'

      expect{ deliverer.deliver!(rails_message_html) }.to raise_error(ElasticEmail::Error)
    end

  end

  def mock_request(request_params, body)
    stub_request(:post, client.elastic_email_send_url).
        with(:body => request_params,
             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                          'Content-Type'=>'application/x-www-form-urlencoded',
                          'Host'=>'api.elasticemail.com', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => body, :headers => {})
  end

end