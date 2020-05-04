# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HttpRepository do
  let(:repository) { described_class.new(logger: logger) }
  let(:logger) { instance_double('Logger') }

  describe '#get' do
    shared_examples :failure_response do
      [
        [400, :http_request_error],
        [422, :http_request_error],
        [499, :http_request_error],
        [500, :http_application_error],
        [503, :http_application_error],
        [599, :http_application_error],
        [100, :http_unknown_response_error],
        [300, :http_unknown_response_error],
        [600, :http_unknown_response_error]

      ].each do |response_code, failure_message|
        context "when response code is #{response_code}" do
          let(:response_code) { response_code }
          let(:failure_message) { failure_message }

          it "fails with message #{failure_message}" do
            is_expected.to be_failure
            expect(subject.failure).to eq(failure_message)
          end
        end
      end
    end

    shared_examples :success_response do
      [200, 201, 204, 299].each do |response_code|
        context "when response code is #{response_code}" do
          let(:response_code) { response_code }
          let(:failure_message) { failure_message }

          it 'succeeds with response' do
            is_expected.to be_success
            expect(subject.success).to eq(response)
          end
        end
      end
    end

    subject { repository.get(url, **options) }
    let(:url) { 'https://test.host/path' }
    let(:response) { instance_double('HTTParty::Response', code: response_code) }
    let(:request_options) do
      {
        logger:           logger,
        log_level:        :debug,
        log_format:       :curl,
        rails_on:         [],
        follow_redirects: false,
        **options
      }
    end

    before { expect(HTTParty).to receive(:get).with(url, **request_options) { response } }

    context 'with options' do
      let(:options) { { headers: { 'Authorization': 'auth_token' }, query: { test: 'test' } } }

      it_behaves_like :failure_response
      it_behaves_like :success_response
    end

    context 'without options' do
      let(:options) { {} }

      it_behaves_like :failure_response
      it_behaves_like :success_response
    end
  end
end
