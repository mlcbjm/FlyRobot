# -*- coding: utf-8 -*-

module V1
	class OrderCostApi < Grape::API
		helpers CommonHelpers
		helpers ParamsHelpers

		resources :order_cost do
			params do
				#use :access_params
				requires :order_cost, type: Hash do
					requires :cost_type_id, type: String
				end
			end
			post 'change' do
				authenticate!
				if !(params[:order_cost][:id] == "" || params[:order_cost][:id].nil?)
					order_cost = OrderCost.find(params[:order_cost][:id])
					order_cost.client_id = params[:order_cost][:client_id]
					order_cost.order_id = params[:order_cost][:order_id]
					order_cost.cost_type_id = params[:order_cost][:cost_type_id]
					order_cost.pay_money = params[:order_cost][:pay_money]
					order_cost.pay_time = params[:order_cost][:pay_time]
					order_cost.notes = params[:order_cost][:notes]
					order_cost.save
				else
					order_cost = OrderCost.new
					order_cost.client_id = params[:order_cost][:client_id]
					order_cost.order_id = params[:order_cost][:order_id]
					order_cost.cost_type_id = params[:order_cost][:cost_type_id]
					order_cost.pay_money = params[:order_cost][:pay_money]
					order_cost.pay_time = params[:order_cost][:pay_time]
					order_cost.notes = params[:order_cost][:notes]
					order_cost.c_by = @session.account.id
					order_cost.save
				end
				{
					cost: V1::Entity::OrderCost.represent(order_cost)
				}
			end #    post '/order_cost' do
			get 'list/:pid' do
				authenticate!
				list = OrderCost.where(order_id: params[:pid])
				{
					list: list
				}
			end#    get '/list' do

			get 'client/:pid' do
				authenticate!
				list = OrderCost.where("client_id='#{params[:pid]}' and (month_cost_id = '' or month_cost_id is null)")
				{
					list: list.map {|e|V1::Entity::OrderCost.represent(e)}
				}
			end#    get '/client/:pid' do

			get 'client_month_cost/:mid/:pid' do
				authenticate!
				list = OrderCost.where("client_id='#{params[:pid]}' and (month_cost_id = '' or month_cost_id is null or month_cost_id = '#{params[:mid]}')")
				{
					list: list.map {|e|V1::Entity::OrderCost.represent(e)}
				}
			end#    get '/client/:pid' do
		end

	end #     class ClientContactApi < Grape::API
end #    module Omniknight
