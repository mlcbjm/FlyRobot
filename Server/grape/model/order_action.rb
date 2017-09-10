# coding: utf-8
module Omniknight
	module Model

		class OrderAction < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			belongs_to :order
			
			before_save do |order_action|
				if order_action.c_at == '' || order_action.c_at.nil?
					order_action.c_at = Time.now()
				end
				order_action.u_at = Time.now()
			end

			def c_by_name
				Account.find(self.c_by).vname
			end
		end # class OrderAction < ActiveRecord::Base
	end #module Model

end #module Omniknight