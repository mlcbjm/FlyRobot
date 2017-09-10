# coding: utf-8
module Omniknight
	module Model

		class Cleaning < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			
			has_many :orders

			before_save do |cleaning|
				if cleaning.c_at == '' || cleaning.c_at.nil?
					cleaning.c_at = Time.now()
				end
				cleaning.u_at = Time.now()
			end

		end # class Cleaning < ActiveRecord::Base
	end #module Model

end #module Omniknight
