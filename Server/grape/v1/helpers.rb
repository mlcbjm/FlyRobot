# -*- coding: utf-8 -*-
module CommonHelpers
  def render_error msg, code=200
    error!({ msg: msg }, 200)
  end

  def authenticate!
    @account = @session.nil? ? nil : @session.account
    raise NotLoginErrors.new unless @account
  end

end

module ParamsHelpers
  extend Grape::API::Helpers

  params :access_params do
    optional :session_id, type: String
  end

  params :pagination_params do
    requires :page, type: Integer
    optional :page_limit, type: Integer, default: 10
  end
end

module QiniuHelper

  def upload_to_qiniu fn, account, type = 'image',file_name = Time.now.to_i
    key = "#{type}/#{ account.id }/#{file_name}"
    bucket = OKC.qiniu.bucket
    put_policy = Qiniu::Auth::PutPolicy.new(
                                            bucket,     # 存储空间
                                            key,        # 最终资源名，可省略，即缺省为“创建”语义
                                            # expires_in, # 相对有效期，可省略，缺省为3600秒后 uptoken 过期
                                            # deadline    # 绝对有效期，可省略，指明 uptoken 过期期限（绝对值），通常用于调试
                                            )

    uptoken = Qiniu::Auth.generate_uptoken(put_policy)
    data = Qiniu.upload_file :uptoken => uptoken, :file => fn, :bucket => bucket, :key => key

    d "upload code: #{data}"
    return key
  end # def upload_to_qiniu fn
end # qiniu helper