# -*- coding: utf-8 -*-

module V1
	class TankApi < Grape::API
		helpers CommonHelpers
		helpers ParamsHelpers

		resources :tank do
			get 'detail/:tank_no' do
				authenticate!
				tank = Tank.find_by_tank_no(params[:tank_no])
				{
					tank: V1::Entity::Tank.represent(tank)
				}
			end#    get '/detail' do
		end

	end #     class TankApi < Grape::API
end #    module Omniknight
