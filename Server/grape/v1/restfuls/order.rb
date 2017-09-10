# -*- coding: utf-8 -*-

module V1
	class OrderApi < Grape::API
		helpers CommonHelpers
		helpers ParamsHelpers

		resources :order do
			params do
				#use :access_params
				requires :order, type: Hash do
					requires :order_type, type: String
				end
			end
			post 'change' do
				authenticate!
				if !(params[:order][:id] == "" || params[:order][:id].nil?)
					order = Order.find(params[:order][:id])
					order.order_no = params[:order][:order_no]
					order.client_no = params[:order][:client_no]
					order.order_type = params[:order][:order_type]
					order.status = params[:order][:status]
					order.client_id = params[:order][:client_id]
					order.service_id = params[:order][:service_id]
					order.client_contact_id = params[:order][:client_contact_id]
					order.box_division_id = params[:order][:box_division_id]
					order.box_location = params[:order][:box_location]
					tank = Tank.find_by_tank_no(params[:order][:tank][:tank_no])
					tank = Tank.new if !tank
					tank.tank_no = params[:order][:tank][:tank_no]
					tank.manufacture_date = params[:order][:tank][:manufacture_date]
					tank.tank_type = params[:order][:tank][:tank_type]
					tank.tare_weight = params[:order][:tank][:tare_weight]
					tank.gross_weight = params[:order][:tank][:gross_weight]
					tank.manufacture_date = params[:order][:tank][:manufacture_date]
					tank.capacity = params[:order][:tank][:capacity]
					tank.save
					order.tank_id = tank.id
					order.cleaning_id = params[:order][:cleaning_id]
					order.pre_installed = params[:order][:pre_installed]
					order.start_at = params[:order][:start_at]
					order.finish_at = params[:order][:finish_at]
					order.end_at = params[:order][:end_at]
					order.last_cargo = params[:order][:last_cargo]
					order.last_cargo_no = params[:order][:last_cargo_no]
					order.next_cargo_no = params[:order][:next_cargo_no]
					order.bottom_discharging = params[:order][:bottom_discharging]
					order.serial_no = params[:order][:serial_no]
					order.team_id = @session.account.team_id
					order.save
					if params[:order][:order_template_value]
						order_template_value = params[:order][:order_template_value]
						order_template_value.each  do |k,v|
							ocvs = OrderCustomizeValue.where(order_id: order.id,order_template_list_id: v.id)
							if ocvs.length>0
								ocv = ocvs.last
							else
								ocv = OrderCustomizeValue.new
							end
							ocv.order_id = order.id
							ocv.order_template_list_id = v.id
							ocv.customize_result = v.value
							ocv.save
						end 
					end
					action = OrderAction.new
					action.vname="填写了订单"
					action.order_id = order.id
					action.c_by = @session.account.id
					action.save
				else
					order = Order.new
					now = Time.now.strftime("%Y%m%d")
					last_order_list = Order.where("order_no like '#{now}%'")
					order.order_no = now+"001"
					order.order_no = last_order_list.last.order_no.to_i+1 if last_order_list.length>0
					d order.order_no
					order.order_type = params[:order][:order_type]
					order.client_no = params[:order][:client_no]
					order.status = params[:order][:status]
					order.client_id = params[:order][:client_id]
					order.service_id = params[:order][:service_id]
					order.client_contact_id = params[:order][:client_contact_id]
					order.box_division_id = params[:order][:box_division_id]
					order.box_location = params[:order][:box_location]
					tank = Tank.find_by_tank_no(params[:order][:tank][:tank_no])
					tank = Tank.new if !tank
					tank.tank_no = params[:order][:tank][:tank_no]
					tank.tank_type = params[:order][:tank][:tank_type]
					tank.tare_weight = params[:order][:tank][:tare_weight]
					tank.gross_weight = params[:order][:tank][:gross_weight]
					tank.manufacture_date = params[:order][:tank][:manufacture_date]
					tank.capacity = params[:order][:tank][:capacity]
					tank.save
					order.tank_id = tank.id
					order.cleaning_id = params[:order][:cleaning_id]
					order.pre_installed = params[:order][:pre_installed]
					order.start_at = params[:order][:start_at]
					order.finish_at = params[:order][:finish_at]
					order.end_at = params[:order][:end_at]
					order.last_cargo = params[:order][:last_cargo]
					order.last_cargo_no = params[:order][:last_cargo_no]
					order.next_cargo_no = params[:order][:next_cargo_no]
					order.bottom_discharging = params[:order][:bottom_discharging]
					order.serial_no = params[:order][:serial_no]
					order.team_id = @session.account.team_id
					order.c_by = @session.account.id
					order.status = 0
					order.save
					if params[:order][:order_template_value]
						order_template_value = params[:order][:order_template_value]
						order_template_value.each  do |k,v|
							ocv = OrderCustomizeValue.new
							ocv.order_id = order.id
							ocv.order_template_list_id = v.id
							ocv.customize_result = v.value
							ocv.save
						end 
					end
					action = OrderAction.new
					action.vname="新建了订单"
					action.order_id = order.id
					action.c_by = @session.account.id
					action.save
				end
				{
					order: V1::Entity::Order.represent(order)
				}
			end #    post '/change' do

			post 'change_status' do
				authenticate!
				order = Order.find(params[:change][:order_id])
				if params[:change][:order_status].to_i == 0 
					order.status = 1
					order.finish_at = params[:change][:date]
					order.save
					action = OrderAction.new
					action.vname="完成了订单"
					action.order_id = order.id
					action.c_by = @session.account.id
					action.save
				elsif params[:change][:order_status].to_i == 1
					order.status = 2
					order.confirm_at = params[:change][:date]
					order.save
					action = OrderAction.new
					action.vname="确认了订单"
					action.order_id = order.id
					action.c_by = @session.account.id
					action.save
				elsif params[:change][:order_status].to_i == 2
					order.status = 3
					order.end_at = params[:change][:date]
					order.save
					action = OrderAction.new
					action.vname="归档了订单"
					action.order_id = order.id
					action.c_by = @session.account.id
					action.save
				end
				{
					order: V1::Entity::Order.represent(order)
				}
			end #    post '/change_status' do

			post 'list' do
				authenticate!

				page = params[:page].to_i
				page = 1 if page < 1
				page_count = params[:page_count].nil? ? 20 : params[:page_count].to_i
				l = Order.joins(:tank).where(team_id: @session.account.team_id)
				if @session.account.role.to_i == 3
					l=l.where(box_division_id: @session.account.id)
				end
				if @session.account.role.to_i == 2
					l=l.where(service_id: @session.account.id)
				end
				if params[:search]
					if params[:search][:tank_no]
						l = l.where("(tank_no like '%#{params[:search][:tank_no]}%' or order_no like '%#{params[:search][:tank_no]}%' or client_no like '%#{params[:search][:tank_no]}%')")
					end
					l = l.where(status: params[:search][:status]) if params[:search][:status]
					l = l.where(order_type: params[:search][:order_type]) if params[:search][:order_type]
					l = l.where(client_id: params[:search][:client]) if params[:search][:client]
					if params[:search][:date_type].to_i == 0			
						l = l.where("start_at >= '#{Time.parse(params[:search][:c_at_start])}'") if params[:search][:c_at_start]
						l = l.where("start_at <= '#{Time.parse(params[:search][:c_at_end])}'") if params[:search][:c_at_end]
					elsif params[:search][:date_type].to_i == 1
						l = l.where("finish_at >= '#{Time.parse(params[:search][:c_at_start])}'") if params[:search][:c_at_start]
						l = l.where("finish_at <= '#{Time.parse(params[:search][:c_at_end])}'") if params[:search][:c_at_end]
					elsif params[:search][:date_type].to_i == 2
						l = l.where("end_at >= '#{Time.parse(params[:search][:c_at_start])}'") if params[:search][:c_at_start]
						l = l.where("end_at <= '#{Time.parse(params[:search][:c_at_end])}'") if params[:search][:c_at_end]
					end
				end
				list = l.limit(page_count).offset((page-1)*page_count)
				if !params[:search]
					clients = Client.where(team_id: @session.account.team_id)
					box_divisions = Account.where(team_id: @session.account.team_id,role: 3)
					services = []
					if @session.account.role.to_i != 2
						services=Account.where(team_id: @session.account.team_id,role: 2)
					else
						services=Account.where(id: @session.account.id)
					end
					k = Order.where(team_id: @session.account.team_id)
					if @session.account.role.to_i == 3
						k=k.where(box_division_id: @session.account.id)
					end
					if @session.account.role.to_i == 2
						k=k.where(service_id: @session.account.id)
					end
					beginning_of_day =Date.today.to_s
					end_of_day = (Date.today+1).to_s
					today_finish = k.where("finish_at >= '#{beginning_of_day}' and finish_at < '#{end_of_day}'").count
					total_finish = k.where("status != 0 ").count
					today_un_finish = k.where("start_at >= '#{beginning_of_day}' and start_at < '#{end_of_day}' and ifnull(finish_at,'') =''").count
					total_un_finish = k.where(status: 0).count
					order_template_0 = OrderTemplate.where(team_id: @session.account.team_id,order_type: 0,is_valid: 1)
					order_template_1 = OrderTemplate.where(team_id: @session.account.team_id,order_type: 1,is_valid: 1)
					cleanings = Cleaning.all
				else
					clients = []
					box_divisions = []
					services = []
					order_template_0 = []
					order_template_1 = []
					cleanings = []
				end
				{
					list: list.map {|e|V1::Entity::Order.represent(e)},
					clients: clients.map {|e|V1::Entity::Client.represent(e)},
					cleanings: cleanings,
					order_template_0: order_template_0.map {|e|V1::Entity::OrderTemplate.represent(e)},
					order_template_1: order_template_1.map {|e|V1::Entity::OrderTemplate.represent(e)},
					box_divisions: box_divisions,
					services: services,
					sum_page: (l.count / page_count.to_f).ceil,
					today_finish: today_finish,
					total_finish: total_finish,
					today_un_finish: today_un_finish,
					total_un_finish: total_un_finish,
					cur_page: page,
				}
			end#    get '/list' do

			get 'detail/:pid' do
				authenticate!
				order = Order.find(params[:pid])
				order_costs = OrderCost.where(order_id: params[:pid])
				files = OrderFile.where(order_id: params[:pid])
				clients = Client.where(team_id: @session.account.team_id)
				cost_types = CostType.where(team_id: @session.account.team_id)
				order_actions = OrderAction.where(order_id: params[:pid])
				{
					order: V1::Entity::Order.represent(order),
					clients: clients,
					files: files,
					cost_types: cost_types.map {|e|V1::Entity::CostType.represent(e)},
					order_costs: order_costs.map {|e|V1::Entity::OrderCost.represent(e)},
					order_actions: order_actions.map {|e|V1::Entity::OrderAction.represent(e)},
				}
			end#    get '/detail' do
		end

	end #     class cleaningApi < Grape::API
end #    module Omniknight
