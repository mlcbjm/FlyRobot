# coding: utf-8
module Omniknight
	module Model

		class MonthCost < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			has_many :order_costs
			belongs_to :client
			
			before_save do |month_cost|
				if month_cost.c_at == '' || month_cost.c_at.nil?
					month_cost.c_at = Time.now()
				end
				month_cost.u_at = Time.now()
			end

			def order_cost_ids
				self.order_costs.collect{|e|e.id}
			end

			def c_by_name
				Account.find(self.c_by).vname
			end
		end # class MonthCost < ActiveRecord::Base
	end #module Model

end #module Omniknight