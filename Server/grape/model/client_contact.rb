# coding: utf-8
module Omniknight
	module Model

		class ClientContact < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			belongs_to :client
			
			before_save do |client_contact|
				if client_contact.c_at == '' || client_contact.c_at.nil?
					client_contact.c_at = Time.now()
				end
				client_contact.u_at = Time.now()
			end

		end # class ClientContact < ActiveRecord::Base
	end #module Model

end #module Omniknight