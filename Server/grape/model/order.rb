# coding: utf-8
module Omniknight
	module Model

		class Order < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			
			belongs_to :tank
			belongs_to :cleaning
			has_many :order_customize_values
			has_many :order_files
			has_many :order_costs
			has_many :order_actions


			before_save do |order|
				if order.c_at == '' || order.c_at.nil?
					order.c_at = Time.now()
				end
				order.u_at = Time.now()
			end

			def client_name
				Client.find(self.client_id).vname if self.client_id
			end

			def box_division_name
				Account.find(self.box_division_id).vname if self.box_division_id
			end

			def service_name
				Account.find(self.service_id).vname if self.service_id
			end

			def client_contact_name
				ClientContact.find(self.client_contact_id).vname if self.client_contact_id
			end

		end # class Order < ActiveRecord::Base
	end #module Model

end #module Omniknight
