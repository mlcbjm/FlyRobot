# -*- coding: utf-8 -*-

module V1
	class CostTypeApi < Grape::API
		helpers CommonHelpers
		helpers ParamsHelpers

		resources :cost_type do
			params do
				#use :access_params
				requires :cost_type, type: Hash do
					requires :vname, type: String
				end
			end
			post 'change' do
				authenticate!
				if !(params[:cost_type][:id] == "" || params[:cost_type][:id].nil?)
					cost_type = CostType.find(params[:cost_type][:id])
					cost_type.vname = params[:cost_type][:vname]
					cost_type.is_valid = params[:cost_type][:is_valid]
					cost_type.team_id = @session.account.team_id
					cost_type.save
				else
					old_time = CostType.where("vname='#{params[:cost_type][:vname]}' and team_id=#{@session.account.team_id}")
					render_error "名称被占用" if old_time.count>0
					cost_type = CostType.new
					cost_type.vname = params[:cost_type][:vname]
					cost_type.is_valid = params[:cost_type][:is_valid]
					cost_type.team_id = @session.account.team_id
					cost_type.save
				end
				{
					cost_type: V1::Entity::CostType.represent(cost_type)
				}
			end #    post '/cost_type' do
			get 'list' do
				authenticate!
				list = CostType.all.where(team_id: @session.account.team_id)

				{
					list: list
				}
			end#    get '/list' do
		end

	end #     class cleaningApi < Grape::API
end #    module Omniknight
