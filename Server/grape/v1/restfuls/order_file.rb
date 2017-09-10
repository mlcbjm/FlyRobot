# -*- coding: utf-8 -*-

module V1
	class OrderFileApi < Grape::API
		helpers CommonHelpers
		helpers ParamsHelpers
		helpers QiniuHelper

		resources :order_file do
			get 'list/:pid' do
				authenticate!
				list = OrderFile.where(order_id: params[:pid])
				{
					list: list
				}
			end#    get '/list' do

			post 'delete/:pid' do
				authenticate!
				a = OrderFile.find(params[:pid])
				a.is_deleted = true
				a.save
				{

				}
			end#    get '/list' do

			get 'download/:pid' do
				a = OrderFile.find(params[:pid])
				primitive_url = 'http://7xrwiz.com1.z0.glb.clouddn.com/'+a.file_url
				download_url = Qiniu::Auth.authorize_download_url(primitive_url)
				d download_url
				{
					download_url: download_url
				}
			end

			post 'upload' do
				authenticate!
				image_url = upload_to_qiniu params[:file][:tempfile].path, @session.account, params[:file_type],params[:file][:filename]
				order_file = OrderFile.new
				order_file.file_name = params[:file][:filename]
				order_file.file_size = params[:file_size]
				order_file.file_url = image_url
				order_file.file_type = params[:file_type]
				order_file.order_id = params[:order_id]
				order_file.save
				{
					file: order_file
				}
			end #    post '/upload' do

		end

	end #     class OrderFileApi < Grape::API
end #    module Omniknight
