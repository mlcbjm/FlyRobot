module V1
	module Entity
		class Base < Grape::Entity
			expose :cname
		end

		class Account < Grape::Entity
			expose :id
			expose :cname
			expose :vname
			expose :team_id
			expose :role
			expose :phone
			expose :addr
			expose :photo
			expose :ename
			expose :email
			expose :head_url
		end # class Account

		class Team < Grape::Entity
			expose :id
			expose :vname
			expose :admin_cname
			expose :admin_password
			expose :url_address
			expose :number
			expose :is_valid
			expose :c_at
		end # class Team


		class Tank < Grape::Entity
			expose :id
			expose :tare_weight
			expose :tank_no
			expose :tank_type
			expose :gross_weight
			expose :capacity
			expose :manufacture_date
		end # class Tank

		class Cleaning < Grape::Entity
			expose :id
			expose :vname
			expose :ename
			expose :address
			expose :contact
			expose :contact_address
			expose :contact_email
			expose :contact_address
			expose :contact_address_ename
			expose :contact_tel
			expose :contact_phone
			expose :location
			expose :county
		end # class Cleaning

		class Client < Grape::Entity
			expose :id
			expose :vname
			expose :address
			expose :fax
			expose :pname
			expose :webaddr
			expose :client_contacts
		end # class Client

		class ClientContact < Grape::Entity
			expose :id
			expose :vname
			expose :phone
			expose :email
			expose :client_id
		end # class ClientContact

		class OrderCost < Grape::Entity
			expose :id
			expose :order
			expose :client
			expose :cost_type
			expose :pay_money
			expose :notes
			expose :cost_type_id
			expose :client_id
			expose :month_cost
			expose :month_cost_id
			expose :pay_time
			expose :tank_no
			expose :cleaning_address
			expose :c_by_name
		end # class ClientContact

		class OrderAction < Grape::Entity
			expose :id
			expose :vname
			expose :c_by_name
			expose :c_at
			expose :order_id
		end # class ClientContact

		class OrderFile < Grape::Entity
			expose :id
			expose :file_name
			expose :file_size
			expose :file_url
			expose :file_type
			expose :order_id
		end # class OrderFile

		class OrderTemplate < Grape::Entity
			expose :id
			expose :vname
			expose :order_type
			expose :is_valid
			expose :team_id
			expose :order_template_lists
		end # class OrderTemplate

		class OrderTemplateList < Grape::Entity
			expose :id
			expose :vname
			expose :input_type
			expose :is_valid
			expose :order_template_id
			expose :number
			expose :result_number
		end # class OrderTemplateList

		class MonthCost < Grape::Entity
			expose :id
			expose :year
			expose :month
			expose :client_id
			expose :client
			expose :status
			expose :pay_date
			expose :team_id
			expose :order_cost_ids
			expose :c_by_name
			expose :total_pay_money
			expose :c_at
		end # class MonthCost

		class CostType < Grape::Entity
			expose :id
			expose :vname
			expose :is_valid
			expose :team_id
		end # class CostType

		class Order < Grape::Entity
			expose :id
			expose :order_no
			expose :client_no
			expose :order_type
			expose :status
			expose :c_at
			expose :client_id
			expose :client_name
			expose :client_contact_id
			expose :client_contact_name
			expose :service_id
			expose :service_name
			expose :box_division_id
			expose :box_division_name
			expose :box_location
			expose :tank_id
			expose :tank
			expose :cleaning_id
			expose :cleaning
			expose :pre_installed
			expose :start_at
			expose :finish_at
			expose :end_at
			expose :last_cargo
			expose :last_cargo_no
			expose :next_cargo_no
			expose :bottom_discharging
			expose :serial_no
			expose :order_customize_values
		end # class Order
	end
end
