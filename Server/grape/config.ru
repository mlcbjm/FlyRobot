# -*- coding: utf-8 -*-
require 'rubygems'
require 'bundler'

Bundler.require(:default)

require_relative 'config/config'

require 'qiniu'
Qiniu.establish_connection! :access_key => OKC.qiniu.ak,
                            :secret_key => OKC.qiniu.sk

Grape::ActiveRecord.configure_from_file! 'config/database.yml'
use ActiveRecord::ConnectionAdapters::ConnectionManagement

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

require_relative 'dispatch'
run Omniknight::Api::Dispatch
