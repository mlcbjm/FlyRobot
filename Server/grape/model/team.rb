# coding: utf-8
module Omniknight
	module Model

		class Team < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			
			before_save do |team|
				if team.c_at == '' || team.c_at.nil?
					team.c_at = Time.now()
				end
				team.u_at = Time.now()
			end

		end # class Team < ActiveRecord::Base
	end #module Model

end #module Omniknight
