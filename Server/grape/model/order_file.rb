# coding: utf-8
module Omniknight
	module Model

		class OrderFile < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			belongs_to :order
			
			before_save do |order_file|
				if order_file.c_at == '' || order_file.c_at.nil?
					order_file.c_at = Time.now()
				end
				order_file.u_at = Time.now()
			end
		end # class OrderCost < ActiveRecord::Base
	end #module Model

end #module Omniknight