# -*- coding: utf-8 -*-

require_relative 'spec_helper'

account = {
  username: '18357101332',
  password: '123456',
}
url = "/api/v1/"
vcode = ""
session_id = ""

describe Omniknight::Api::Dispatch do
  include Rack::Test::Methods

  def app
    Omniknight::Api::Dispatch
  end

 # end of context

  # context "获得验证码" do
  #   it 'vcodes' do
  #     params = {
  #       client_version: 'app 2.0.0',
  #       phone: account[:phone],
  #       usage: 'signup',
  #     }.to_json

  #     post "#{url}/vcodes", params, 'CONTENT_TYPE' => 'application/json'

  #     body = JSON.parse(last_response.body)
  #     d body
  #     vcode = body["data"]["vcode"] if body["data"] && body["data"]["vcode"]

  #     expect(body["status"]["success"]).to eq true
  #     expect(last_response.status).to eq 200
  #   end
  # end # end of context

  context "注册" do
    it 'signup' do
      params = {
        account: {
          username: account[:username],
          password: account[:password],
        }
      }.to_json

      post "#{url}/signup", params, 'CONTENT_TYPE' => 'application/json'

      expect(last_response.status).to eq 200

      body = JSON.parse(last_response.body)
      d body

      session_id = body["data"]["session_id"]
    end
  end # end of context

  # context "登陆" do
  #   it 'signin' do
  #     params = {
  #       client_version: 'app 2.0.0',
  #       stat: {device: 'iphone 5s'},
  #       ios_token: 'asda02asa02cas03as03bas833382na',
  #       partner_cname: 'dzh',
  #       account: {
  #         phone: account[:phone],
  #         password: account[:password],
  #       }
  #     }.to_json

  #     post "#{url}/signin", params, 'CONTENT_TYPE' => 'application/json'

  #     body = JSON.parse(last_response.body)
  #     d body

  #     expect(last_response.status).to eq 200

  #     session_id = body["data"]["session_id"]
  #   end
  # end # end of context

  # context "注销" do
  #   it 'signout' do
  #     params = {
  #       client_version: 'app 2.0.0',
  #       session_id: session_id,
  #     }.to_json

  #     post "#{url}/signout", params, 'CONTENT_TYPE'=>'application/json'

  #     expect(last_response.status).to eq 200

  #     body = JSON.parse(last_response.body)
  #     d body
  #   end
  # end # end of context

  # context "修改登陆密码" do
  #   it '/passwords/signin/change' do
  #     params = {
  #       client_version: 'app 2.0.0',
  #       session_id: session_id,
  #       old_password: account[:password],
  #       new_password: account[:password],
  #     }.to_json

  #     post("#{url}/passwords/signin/change", 
  #          params, 
  #          'CONTENT_TYPE'=>'application/json')

  #     expect(last_response.status).to eq 200

  #     body = JSON.parse(last_response.body)
  #     d body
  #   end
  # end # end of context

  # context "重置登陆密码" do
  #   it '/passwords/signin/reset' do
  #     params = {
  #       client_version: 'app 2.0.0',
  #       session_id: session_id,
  #       phone: account[:phone],
  #       vcode: vcode,
  #       password: account[:password],
  #     }.to_json

  #     post("#{url}/passwords/signin/reset", 
  #          params, 
  #          'CONTENT_TYPE'=>'application/json')

  #     expect(last_response.status).to eq 200

  #     body = JSON.parse(last_response.body)
  #     d body
  #   end
  # end # end of context

  # context "创建支付密码" do
  #   it '/passwords/pay/create' do
  #     params = {
  #       client_version: 'app 2.0.0',
  #       session_id: session_id,
  #       password: account[:password],
  #     }.to_json

  #     post("#{url}/passwords/pay/create", 
  #          params, 
  #          'CONTENT_TYPE'=>'application/json')

  #     expect(last_response.status).to eq 200

  #     body = JSON.parse(last_response.body)
  #     d body
  #   end
  # end # end of context

  # context "重置支付密码" do
  #   it '/passwords/pay/reset' do
  #     params = {
  #       client_version: 'app 2.0.0',
  #       session_id: session_id,
  #       password: account[:password],
  #       vcode: vcode,
  #     }.to_json

  #     post("#{url}/passwords/pay/reset", 
  #          params, 
  #          'CONTENT_TYPE'=>'application/json')

  #     expect(last_response.status).to eq 200

  #     body = JSON.parse(last_response.body)
  #     d body
  #   end
  # end # end of context

  # context "获取银行卡" do
  #   it '/bankcards/info' do
  #     params = {
  #       client_version: 'app 2.0.0',
  #       session_id: session_id,
  #     }.to_json

  #     post("#{url}/bankcards/info", 
  #          params, 
  #          'CONTENT_TYPE'=>'application/json')

  #     expect(last_response.status).to eq 200

  #     body = JSON.parse(last_response.body)
  #     d body
  #   end
  # end # end of context

  # context "绑定银行卡" do
  #   it '/bankcards/create' do
  #     params = {
  #       client_version: 'app 2.0.0',
  #       session_id: session_id,
  #       bank_code: 'ICBC',
  #       card_code: '6262626262626262',
  #       card_id: '6262626262626262',
  #       true_name: 'lsc',
  #       identity_id: '33060219871160034',
  #       province: 'zj',
  #       city: 'hz',
  #     }.to_json

  #     post("#{url}/bankcards/create", 
  #          params, 
  #          'CONTENT_TYPE'=>'application/json')

  #     expect(last_response.status).to eq 200

  #     body = JSON.parse(last_response.body)
  #     d body
  #   end
  # end # end of context
end
