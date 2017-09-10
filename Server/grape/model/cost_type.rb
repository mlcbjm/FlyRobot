# coding: utf-8
module Omniknight
	module Model

		class CostType < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			has_many :order_costs
			
			before_save do |cost_type|
				if cost_type.c_at == '' || cost_type.c_at.nil?
					cost_type.c_at = Time.now()
				end
				cost_type.u_at = Time.now()
			end

		end # class CostType < ActiveRecord::Base
	end #module Model

end #module Omniknight