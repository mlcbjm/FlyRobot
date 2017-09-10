# -*- coding: utf-8 -*-
require_relative '../lib/logger_with_lineno'
require_relative '../lib/utils'
require_relative 'v1/root'
Dir["model/*.rb"].each{ |file|
  require_relative file
  l file
}

include Omniknight::Model

module Omniknight
  module Api

    class Dispatch < Grape::API
      mount V1::Root

      format :json
      content_type :json, 'application/json;charset=utf-8'

      route :any, '*path' do
        d params
        status 404
        { error: 'page not found.' }
      end
    end # class Dispatch

  end # module Api
end # module Omniknight
