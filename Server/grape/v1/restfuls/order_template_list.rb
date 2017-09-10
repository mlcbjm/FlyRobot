# -*- coding: utf-8 -*-

module V1
	class OrderTemplateListApi < Grape::API
		helpers CommonHelpers
		helpers ParamsHelpers

		resources :order_template_list do
			params do
				#use :access_params
				requires :order_template_list, type: Hash do
					requires :vname, type: String
					requires :input_type, type: String
				end
			end
			post 'change' do
				authenticate!
				if !(params[:order_template_list][:id] == "" || params[:order_template_list][:id].nil?)
					order_template_list = OrderTemplateList.find(params[:order_template_list][:id])
					order_template_list.vname = params[:order_template_list][:vname]
					order_template_list.input_type = params[:order_template_list][:input_type]
					order_template_list.is_valid = params[:order_template_list][:is_valid]
					order_template_list.order_template_id = params[:order_template_list][:order_template_id]
					order_template_list.result_number = params[:order_template_list][:result_number]
					if params[:order_template_list][:input_type].to_i ==1
						order_template_list.customizes = params[:order_template_list][:number].collect{|k,v|v.value}.join('&&')
					end
					order_template_list.save
				else
					old_time = OrderTemplateList.where("vname='#{params[:order_template_list][:vname]}'")
					render_error "名称被占用" if old_time.count>0
					order_template_list = OrderTemplateList.new
					order_template_list.vname = params[:order_template_list][:vname]
					order_template_list.input_type = params[:order_template_list][:input_type]
					order_template_list.is_valid = params[:order_template_list][:is_valid]
					order_template_list.order_template_id = params[:order_template_list][:order_template_id]
					order_template_list.result_number = params[:order_template_list][:result_number]
					if params[:order_template_list][:input_type].to_i ==1
						order_template_list.customizes = params[:order_template_list][:number].collect{|k,v|v.value}.join('&&')
					end
					order_template_list.save
				end
				{
					order_template_list: V1::Entity::OrderTemplateList.represent(order_template_list)
				}
			end #    post '/order_template_list' do
			get 'list/:pid' do
				authenticate!
				order_template = OrderTemplate.find(params[:pid])
				list = OrderTemplateList.where(order_template_id: params[:pid])
				{
					list: list.map {|e|V1::Entity::OrderTemplateList.represent(e)},
					order_template: order_template,
				}
			end#    get '/list' do
		end

	end #     class OrderTemplateApi < Grape::API
end #    module Omniknight
