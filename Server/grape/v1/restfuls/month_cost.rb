# -*- coding: utf-8 -*-

module V1
	class MonthCostApi < Grape::API
		helpers CommonHelpers
		helpers ParamsHelpers

		resources :month_cost do
			params do
				#use :access_params
				requires :month_cost, type: Hash do
					requires :year, type: String
					requires :month, type: String
				end
			end
			post 'change' do
				authenticate!
				if !(params[:month_cost][:id] == "" || params[:month_cost][:id].nil?)
					month_cost = MonthCost.find(params[:month_cost][:id])
					month_cost.year = params[:month_cost][:year]
					month_cost.month = params[:month_cost][:month]
					month_cost.client_id = params[:month_cost][:client_id]
					month_cost.pay_date = params[:month_cost][:pay_date]
					month_cost.status = params[:month_cost][:status]
					month_cost.team_id = @session.account.team_id
					month_cost.save
					month_cost.order_costs.each{|e|e.month_cost_id="";e.save}
					if params[:month_cost][:order_cost_ids].length >0
						params[:month_cost][:order_cost_ids].each do |e|
							a = OrderCost.find(e)
							a.month_cost_id = month_cost.id
							a.save
						end
					end
					month_cost.total_pay_money = month_cost.order_costs.sum(:pay_money)
					month_cost.save
				else
					old_time = MonthCost.where("year='#{params[:month_cost][:year]}' and client_id = '#{params[:month_cost][:client_id]}' and month = '#{params[:month_cost][:month]}' and team_id=#{@session.account.team_id}")
					render_error "该月以有账单" if old_time.count>0
					month_cost = MonthCost.new
					month_cost.year = params[:month_cost][:year]
					month_cost.month = params[:month_cost][:month]
					month_cost.client_id = params[:month_cost][:client_id]
					month_cost.pay_date = params[:month_cost][:pay_date]
					month_cost.status = params[:month_cost][:status]
					month_cost.team_id = @session.account.team_id
					month_cost.c_by = @session.account.id
					month_cost.save
					if params[:month_cost][:order_cost_ids].length >0
						params[:month_cost][:order_cost_ids].each do |e|
							a = OrderCost.find(e)
							a.month_cost_id = month_cost.id
							a.save
						end
					end
					month_cost.total_pay_money = month_cost.order_costs.sum(:pay_money)
					month_cost.save
				end
				{
					month_cost: V1::Entity::MonthCost.represent(month_cost)
				}
			end #    post '/change' do

			get 'list' do
				authenticate!
				list = MonthCost.all.where(team_id: @session.account.team_id)
				clients = Client.where(team_id: @session.account.team_id)
				{
					list: list.map {|e|V1::Entity::MonthCost.represent(e)},
					clients: clients,
				}
			end#    get '/list' do

			get 'detail/:pid' do
				authenticate!
				month_cost = MonthCost.find(params[:pid])
				list = month_cost.order_costs
				{
					list: list.map {|e|V1::Entity::OrderCost.represent(e)},
					month_cost: V1::Entity::MonthCost.represent(month_cost),
				}
			end#    get '/list' do
		end

	end #     class cleaningApi < Grape::API
end #    module Omniknight
