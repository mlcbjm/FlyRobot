# -*- coding: utf-8 -*-

module V1
	class CleaningApi < Grape::API
		helpers CommonHelpers
		helpers ParamsHelpers

		resources :cleaning do
			params do
				#use :access_params
				requires :cleaning, type: Hash do
					requires :vname, type: String
					requires :address, type: String
				end
			end
			post 'change' do
				authenticate!
				if !(params[:cleaning][:id] == "" || params[:cleaning][:id].nil?)
					cleaning = Cleaning.find(params[:cleaning][:id])
					cleaning.vname = params[:cleaning][:vname]
					cleaning.ename = params[:cleaning][:ename]
					cleaning.address = params[:cleaning][:address]
					cleaning.contact = params[:cleaning][:contact]
					cleaning.contact_email = params[:cleaning][:contact_email]
					cleaning.contact_address = params[:cleaning][:contact_address]
					cleaning.contact_address_ename = params[:cleaning][:contact_address_ename]
					cleaning.contact_tel = params[:cleaning][:contact_tel]
					cleaning.contact_phone = params[:cleaning][:contact_phone]
					cleaning.save
				else
					old_time = Cleaning.where("vname='#{params[:cleaning][:vname]}'")
					render_error "名称被占用" if old_time.count>0
					cleaning = Cleaning.new
					cleaning.vname = params[:cleaning][:vname]
					cleaning.ename = params[:cleaning][:ename]
					cleaning.address = params[:cleaning][:address]
					cleaning.contact = params[:cleaning][:contact]
					cleaning.contact_email = params[:cleaning][:contact_email]
					cleaning.contact_address = params[:cleaning][:contact_address]
					cleaning.contact_address_ename = params[:cleaning][:contact_address_ename]
					cleaning.contact_tel = params[:cleaning][:contact_tel]
					cleaning.contact_phone = params[:cleaning][:contact_phone]
					cleaning.save
				end
				{
					cleaning: V1::Entity::Cleaning.represent(cleaning)
				}
			end #    post '/cleaning' do
			get 'list' do
				authenticate!
				list = Cleaning.all

				{
					list: list
				}
			end#    get '/list' do
		end

	end #     class cleaningApi < Grape::API
end #    module Omniknight
