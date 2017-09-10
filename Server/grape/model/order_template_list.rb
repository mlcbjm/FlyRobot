# coding: utf-8
module Omniknight
	module Model

		class OrderTemplateList < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			
			before_save do |order_template_list|
				if order_template_list.c_at == '' || order_template_list.c_at.nil?
					order_template_list.c_at = Time.now()
				end
				order_template_list.u_at = Time.now()
			end

			def number
			 	return [] if self.input_type.to_i != 1 || self.customizes.nil?
			 	array = self.customizes.split('&&')
			 	result = []
			 	array.each do |value|
			 		result.push({value: value})
			 	end
			 	return result
			end

		end # class OrderTemplateList < ActiveRecord::Base
	end #module Model

end #module Omniknight