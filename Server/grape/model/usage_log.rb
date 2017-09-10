# coding: utf-8
module Omniknight
  module Model

    # 每日使用记录
    class UsageLog < ActiveRecord::Base
# include Mongoid::Timestamps::Short

      # 账户id
# field :account_id, type: String

      # 账户cname

      # 外部api，传入用户账户，记录每天第一次使用记录
      def self.log_by_day(account_arg)
        a = UsageLog.where(account_id: account_arg.id.to_s).order_by([:c_at, :desc]).first

        if a.nil?
          a = UsageLog.create(account_id: account_arg.id,
                              cname: account_arg.cname)
          l "New log: `#{account_arg.cname}`"
          return
        end # if a.nil?

        #检查最新记录的年月日是不是今天，不是的话就增加，是就忽略
        now = Time.now
        if a.c_at.year == now.year and a.c_at.yday == now.yday
          d "Already logged today for `#{account_arg.cname}`, ignore"
        else
          l "New log: `#{account_arg.cname}`"
          a = UsageLog.create(account_id: account_arg.id,
                              cname: account_arg.cname)
          return
        end

      end# def log(account_arg)



    end # class UsageLog < ActiveRecord::Base
  end #module Model

end #module Omniknight
