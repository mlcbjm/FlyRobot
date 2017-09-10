# coding: utf-8
module Omniknight
	module Model

		class OrderCustomizeValue < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			belongs_to :order
			
			before_save do |order_customize_value|
				if order_customize_value.c_at == '' || order_customize_value.c_at.nil?
					order_customize_value.c_at = Time.now()
				end
				order_customize_value.u_at = Time.now()
			end

		end # class OrderCustomizeValue < ActiveRecord::Base
	end #module Model

end #module Omniknight