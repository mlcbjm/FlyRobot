# -*- coding: utf-8 -*-

module V1
  class AccountApi < Grape::API
    helpers CommonHelpers
    helpers ParamsHelpers
    helpers QiniuHelper

    desc %(用户登陆
    ### Returns:
    ```json
    {
      status: {
        success : true,
        msg     : '',
      },
      data: {
        session_id : 1020203ksbdasd,
        account    : {
          cname           : 111111,
        }
      }
    }
    ```)
    params do
      #use :access_params
      requires :account, type: Hash do
        requires :username, type: String
        requires :password, type: String
      end
    end
    post 'signin' do
      username = params[:account][:username]
      password = params[:account][:password]

      l "User `#{username}` login"
      team = Team.find_by(url_address: @url)
      render_error "团队不可用" if !team.is_valid
      account = Account.login(username, password, @session,team.id)

      render_error "密码/用户名错误" if account.nil?

      {
        session_id: @session.id, 
        account: V1::Entity::Account.represent(account),
        success: true
      }
    end #    post '/signin' do

    params do
      #use :access_params
      requires :account, type: Hash do
        requires :username, type: String
        requires :password, type: String
      end
    end
    post 'add_account' do
      username = params[:account][:username]
      password = params[:account][:password]


    end #    post '/signin' do

    desc %(用户注销
    ### Returns:
    ```json
    {
      status: {
        success : true,
        msg     : '',
      },
      data: true/false
    }
    ```)
    params do
      use :access_params
    end
    post '/signout' do
      authenticate!
      @session.account_signout
      true
    end #    post '/signout' do

    resources :account do
      post 'change' do
        authenticate!
        d params[:account]
        params[:account] = JSON.parse(params[:account])
        if !(params[:account][:id] == "" || params[:account][:id].nil?)
          account = Account.find(params[:account][:id])
          account.vname = params[:account][:vname]
          account.cname = params[:account][:cname]
          account.password = params[:account][:password]
          account.email = params[:account][:email]
          account.role = params[:account][:role]
          account.phone = params[:account][:phone]
          account.ename = params[:account][:ename]
          account.addr = params[:account][:addr]
          if params[:file].to_s != "undefined"
            image_url = upload_to_qiniu params[:file][:tempfile].path, @session.account
            account.head_url = "http://7xrwiz.com1.z0.glb.clouddn.com/"+image_url
          end
          account.save
        else
          old_time = Account.where("cname='#{params[:account][:cname]}' and team_id='#{@session.account.team_id}'")
          render_error "用户名冲突" if old_time.count>1
          account = Account.new
          account.vname = params[:account][:vname]
          account.cname = params[:account][:cname]
          account.password = params[:account][:password] if params[:account][:password]
          account.email = params[:account][:email]
          account.role = params[:account][:role]
          account.phone = params[:account][:phone]
          account.ename = params[:account][:ename]
          account.addr = params[:account][:addr]
          account.team_id = @session.account.team_id
          if params[:file].to_s != "undefined"
            image_url = upload_to_qiniu params[:file][:tempfile].path, @session.account
            account.head_url = "http://7xrwiz.com1.z0.glb.clouddn.com/"+image_url
          end
          account.save
        end
        {
          account: V1::Entity::Account.represent(account)
        }
      end #    post '/account' do
      get 'list' do
        authenticate!
        list = Account.where(team_id: @session.account.team_id)

        {
          list: list
        }
      end#    get '/list' do
    end #      resources :account do
  end #     class AccountApi < Grape::API
end #    module Omniknight
