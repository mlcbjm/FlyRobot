# -*- coding: utf-8 -*-

module V1
	class TeamApi < Grape::API
		helpers CommonHelpers
		helpers ParamsHelpers

		resources :team do
			params do
				#use :access_params
				requires :team, type: Hash do
					requires :vname, type: String
					requires :admin_cname, type: String
					requires :admin_password, type: String
					requires :url_address, type: String
					requires :number, type: String
				end
			end
			post 'change' do
				authenticate!
				if !(params[:team][:id] == "" || params[:team][:id].nil?)
					team = Team.find(params[:team][:id])
					team.vname = params[:team][:vname]
					team.url_address = params[:team][:url_address]
					team.number = params[:team][:number]
					team.admin_cname = params[:team][:admin_cname]
					team.admin_password = params[:team][:admin_password]
					team.is_valid =  params[:team][:is_valid]
					team.save
				else
					old_time = Team.where("url_address='#{params[:team][:url_address]}' or number='#{params[:team][:number]}'")
					render_error "编号或地址被占用" if old_time.count>0
					team = Team.new
					team.vname = params[:team][:vname]
					team.url_address = params[:team][:url_address]
					team.number = params[:team][:number]
					team.admin_cname = params[:team][:admin_cname]
					team.admin_password = params[:team][:admin_password]
					team.is_valid =  params[:team][:is_valid]
					team.save
					account = Account.new
					account.cname = params[:team][:admin_cname]
					account.password = params[:team][:admin_password]
					account.role = 0
					account.team_id = team.id
					account.save
				end
				{
					team: V1::Entity::Team.represent(team)
				}
			end #    post '/team' do
			get 'list' do
				authenticate!
				list = Team.all

				{
					list: list
				}
			end#    get '/list' do
		end

	end #     class TeamApi < Grape::API
end #    module Omniknight
