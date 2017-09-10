# -*- coding: utf-8 -*-

module V1
	class OrderTemplateApi < Grape::API
		helpers CommonHelpers
		helpers ParamsHelpers

		resources :order_template do
			params do
				#use :access_params
				requires :order_template, type: Hash do
					requires :vname, type: String
					requires :order_type, type: String
				end
			end
			post 'change' do
				authenticate!
				if !(params[:order_template][:id] == "" || params[:order_template][:id].nil?)
					order_template = OrderTemplate.find(params[:order_template][:id])
					order_template.vname = params[:order_template][:vname]
					order_template.order_type = params[:order_template][:order_type]
					order_template.is_valid = params[:order_template][:is_valid]
					order_template.team_id = @session.account.team_id
					order_template.save
				else
					old_time = OrderTemplate.where("vname='#{params[:order_template][:vname]}' and order_type = #{params[:order_template][:order_type]}  and team_id=#{@session.account.team_id}")
					render_error "名称被占用" if old_time.count>0
					order_template = OrderTemplate.new
					order_template.vname = params[:order_template][:vname]
					order_template.order_type = params[:order_template][:order_type]
					order_template.is_valid = params[:order_template][:is_valid]
					order_template.team_id = @session.account.team_id
					order_template.save
				end
				{
					order_template: V1::Entity::OrderTemplate.represent(order_template)
				}
			end #    post '/order_template' do
			get 'list' do
				authenticate!
				list = OrderTemplate.where(team_id: @session.account.team_id)

				{
					list: list
				}
			end#    get '/list' do
		end

	end #     class OrderTemplateApi < Grape::API
end #    module Omniknight
