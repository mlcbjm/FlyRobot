# -*- coding: utf-8 -*-
module Omniknight
  module ReturnCode

    SUCCESS = '000001'
    FAILED = '100001'
    VERIFIED_FAILED = '100002'
    AUTH_FAILED = '100003'
    WRONG_PARAMS = '100004'
    ALREADY_EXIST = '100005'
    USER_UNREGISTERED = '100006'

    ReturnMsg = {}
    ReturnMsg[SUCCESS] = '操作成功'
    ReturnMsg[FAILED] = '操作失败'
    ReturnMsg[VERIFIED_FAILED] = '数据校验失败'
    ReturnMsg[AUTH_FAILED] = '授权失败'
    ReturnMsg[WRONG_PARAMS] = '参数不正确'
    ReturnMsg[ALREADY_EXIST] = '对象已经存在'
    ReturnMsg[USER_UNREGISTERED] = '用户未注册'

    def self.get_res code, msg=nil
      msg = ReturnMsg[code] if msg.nil?
      {
        res_code: code,
        res_msg: msg,
      }
    end

  end #  module ReturnCode
end #  module Omniknight
