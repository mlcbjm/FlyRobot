# coding: utf-8
module Omniknight
	module Model

		class OrderTemplate < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			
			before_save do |order_template|
				if order_template.c_at == '' || order_template.c_at.nil?
					order_template.c_at = Time.now()
				end
				order_template.u_at = Time.now()
			end

			def order_template_lists
				OrderTemplateList.where(order_template_id: self.id,is_valid: 1)
			end
		end # class OrderTemplate < ActiveRecord::Base
	end #module Model

end #module Omniknight