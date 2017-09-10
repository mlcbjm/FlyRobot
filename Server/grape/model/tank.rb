# coding: utf-8
module Omniknight
	module Model

		class Tank < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			
			has_many :orders

			before_save do |tank|
				if tank.c_at == '' || tank.c_at.nil?
					tank.c_at = Time.now()
				end
				tank.u_at = Time.now()
			end
		end # class Tank < ActiveRecord::Base
	end #module Model

end #module Omniknight
