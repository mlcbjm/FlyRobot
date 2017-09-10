# -*- coding: utf-8 -*-

require_relative 'spec_helper'

url = "/api/v1/"

describe Omniknight::Api::Dispatch do
  include Rack::Test::Methods

  def app
    Omniknight::Api::Dispatch
  end

  # context "获取余额" do
  #   it '/money' do
  #     params = {
  #       client_version: 'app 2.0.0',
  #       session_id: get_session_id,
  #     }.to_json

  #     post "#{url}/money", params, 'CONTENT_TYPE' => 'application/json'
  #     expect(last_response.status).to eq 200

  #     body = JSON.parse(last_response.body)
  #     d body
  #   end
  # end # end of context

end
