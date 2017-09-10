# coding: utf-8
module Omniknight
	module Model

		class OrderCustomize < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			
			before_save do |order_customize|
				if order_customize.c_at == '' || order_customize.c_at.nil?
					order_customize.c_at = Time.now()
				end
				order_customize.u_at = Time.now()
			end

		end # class OrderCustomize < ActiveRecord::Base
	end #module Model

end #module Omniknight