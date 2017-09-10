# coding: utf-8
module Omniknight
	module Model

		class OrderCost < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			belongs_to :order
			belongs_to :cost_type
			belongs_to :client
			belongs_to :month_cost
			
			before_save do |order_cost|
				if order_cost.c_at == '' || order_cost.c_at.nil?
					order_cost.c_at = Time.now()
				end
				order_cost.u_at = Time.now()
			end

			def tank_no
				self.order.tank.tank_no
			end

			def cleaning_address
				self.order.cleaning.address
			end

			def c_by_name
				Account.find(self.c_by).vname
			end
		end # class OrderCost < ActiveRecord::Base
	end #module Model

end #module Omniknight