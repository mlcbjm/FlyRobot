# -*- coding: utf-8 -*-

module V1
	class ClientContactApi < Grape::API
		helpers CommonHelpers
		helpers ParamsHelpers

		resources :client_contact do
			params do
				#use :access_params
				requires :client_contact, type: Hash do
					requires :vname, type: String
					requires :client_id, type: String
				end
			end
			post 'change' do
				authenticate!
				if !(params[:client_contact][:id] == "" || params[:client_contact][:id].nil?)
					client_contact = ClientContact.find(params[:client_contact][:id])
					client_contact.vname = params[:client_contact][:vname]
					client_contact.phone = params[:client_contact][:phone]
					client_contact.email = params[:client_contact][:email]
					client_contact.client_id = params[:client_contact][:client_id]
					client_contact.save
				else
					old_time = ClientContact.where("vname='#{params[:client_contact][:vname]} and client_id=#{params[:client_contact][:client_id]}'")
					render_error "名称被占用" if old_time.count>0
					client_contact = ClientContact.new
					client_contact.vname = params[:client_contact][:vname]
					client_contact.phone = params[:client_contact][:phone]
					client_contact.email = params[:client_contact][:email]
					client_contact.client_id = params[:client_contact][:client_id]
					client_contact.save
				end
				{
					client_contact: V1::Entity::ClientContact.represent(client_contact)
				}
			end #    post '/client_contact' do
			get 'list/:pid' do
				authenticate!
				list = ClientContact.where(client_id: params[:pid])
				client = Client.find(params[:pid])
				{
					list: list,
					client: client
				}
			end#    get '/list' do
		end

	end #     class ClientContactApi < Grape::API
end #    module Omniknight
