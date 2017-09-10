# coding: utf-8
module Omniknight
	module Model

		class Client < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			has_many :client_contacts
			has_many :order_costs
			has_many :month_costs
			
			before_save do |client|
				if client.c_at == '' || client.c_at.nil?
					client.c_at = Time.now()
				end
				client.u_at = Time.now()
			end
		end # class Client < ActiveRecord::Base
	end #module Model

end #module Omniknight
