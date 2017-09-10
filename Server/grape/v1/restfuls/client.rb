# -*- coding: utf-8 -*-

module V1
	class ClientApi < Grape::API
		helpers CommonHelpers
		helpers ParamsHelpers

		resources :client do
			params do
				#use :access_params
				requires :client, type: Hash do
					requires :vname, type: String
				end
			end
			post 'change' do
				authenticate!
				if !(params[:client][:id] == "" || params[:client][:id].nil?)
					client = Client.find(params[:client][:id])
					client.vname = params[:client][:vname]
					client.fax = params[:client][:fax]
					client.address = params[:client][:address]
					client.webaddr = params[:client][:webaddr]
					client.pname = params[:client][:pname]
					client.team_id = @session.account.team_id
					client.save
				else
					old_time = Client.where("vname='#{params[:client][:vname]}' and team_id=#{@session.account.team_id}")
					render_error "名称被占用" if old_time.count>0
					client = Client.new
					client.vname = params[:client][:vname]
					client.fax = params[:client][:fax]
					client.address = params[:client][:address]
					client.webaddr = params[:client][:webaddr]
					client.pname = params[:client][:pname]
					client.team_id = @session.account.team_id
					client.save
				end
				{
					client: V1::Entity::Client.represent(client)
				}
			end #    post '/client' do
			get 'list' do
				authenticate!
				list = Client.where(team_id: @session.account.team_id)
				{
					list: list.map {|e|V1::Entity::Client.represent(e)}
				}
			end#    get '/list' do
		end

	end #     class ClientApi < Grape::API
end #    module Omniknight
