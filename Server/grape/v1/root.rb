# -*- coding: utf-8 -*-
require_relative 'consts'
require_relative 'errors'
require_relative 'helpers'

Dir[File.dirname(__FILE__)+'/restfuls/*.rb'].each{ |file|
  require_relative file
}

Dir[File.dirname(__FILE__)+'/entities/*.rb'].each{ |file|
  require_relative file
}

include V1::Exceptions

module V1
  class Root < Grape::API
    do_not_route_head!
    do_not_route_options!

    # will change url
    prefix :api
    version 'v1'

    content_type :json, 'application/json'
    format :json
    formatter :json, lambda { |object, env|
      {:status => {success: true, msg: ""}, :data => object}.to_json
    }

    default_error_formatter :json
    error_formatter :json, lambda { |message, backtrace, options, env|  
      {:status => {success: false, msg: message[:msg]}}.to_json        
    }

    before do
      d params
      @url = request.url.split('/')[2]
    
      session_key = params[:session]
      @session = AccountSession.load_from_redis(session_key, 
                                                OKC.redis.cookie)
    end

    after do
      @session.save_to_redis OKC.redis.cookie if @session

      # grape post 默认返回是201
      status(200) if request.request_method.to_s.upcase == "POST"
    end

    helpers do
    end
    helpers CommonHelpers
    helpers ParamsHelpers

    rescue_from :all do |e|
      e "Error: #{e}\n#{e.backtrace.join("\n")}\n"

      case e
      when NotLoginErrors
        Rack::Response.new(
                           {
                             status: {
                               success: false,
                               msg: '尚未登陆',
                             },
                             data: {
                               error_type: NotLoginErrors::CODE
                             }
                           }.to_json, 501).finish
      when ClientVersionErrors
        Rack::Response.new(
                           {
                             status: {
                               success: false,
                               msg: '有新版本，需要升级',
                             },
                             data: {
                               error_type: ClientVersionErrors::CODE,
                               detail: e.config,
                             }
                           }.to_json, 501).finish
      when Grape::Exceptions::InvalidMessageBody
        Rack::Response.new(
                           {
                             status: {
                               success: false,
                               msg: '参数不符合要求',
                             },
                             data: e.to_s
                           }.to_json, 500).finish
      when Grape::Exceptions::ValidationErrors
        e e.errors
        Rack::Response.new(
                           {
                             status: {
                               success: false,
                               msg: '参数不符合要求',
                             },
                             data: e.errors
                           }.to_json, 500).finish
      else
        Rack::Response.new(
                           {
                             status: {
                               success: false,
                               msg: 'API 接口异常',
                             },
                           }.to_json, 500).finish
      end
    end

    get 'test' do
      'hello grape'
      # obj = {cname: 'cname-test', vname: 'vname-test'}
      # objs = [obj]
      # present obj, with: V1::Entity::Base
      # V1::Entity::Base.represent obj
      # V1::Entity::Base.represent objs
    end

    mount V1::BaseApi
    mount V1::AccountApi
    mount V1::TeamApi
    mount V1::CleaningApi
    mount V1::OrderTemplateApi
    mount V1::OrderApi
    mount V1::ClientApi
    mount V1::ClientContactApi
    mount V1::TankApi
    mount V1::CostTypeApi
    mount V1::OrderCostApi
    mount V1::MonthCostApi
    mount V1::OrderFileApi
    mount V1::OrderTemplateListApi

    add_swagger_documentation
  end #     class Api < Grape::API
end #    module Omniknight
