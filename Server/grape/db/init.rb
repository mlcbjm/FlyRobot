#!/usr/bin/env ruby
# coding: utf-8

require 'rubygems'
require 'bundler'

Bundler.require(:default)

require_relative '../config/config'
require_relative '../../lib/logger_with_lineno'

# require all models
Dir[File.dirname(__FILE__)+"/../model/*.rb"].each{ |file|
  l file
  next if file.include? 'image.rb'
  next if file.include? 'model.rb'
  load file
}
#config

include Omniknight::Model

Grape::ActiveRecord.configure_from_file! 'config/database.yml'

team = Team.new
team.vname = "超级管理员"
team.admin_cname = "111111"
team.admin_password = "111111"
team.url_address = "127.0.0.1:9527"
team.number = "1000"
team.is_valid = true
team.save
account = Account.new
account.cname = "111111"
account.password = "111111"
account.role = 0
account.team_id = team.id
account.save
