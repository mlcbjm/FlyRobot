# -*- coding: utf-8 -*-
module Omniknight
  module Utils

    def self.dzh_etf_account
      return nil
    end

    # 获取工作日
    def self.skip_weekends(time, days)
      time += days.days
      while (time.wday % 7 == 0) or (time.wday % 7 == 6) do
        time += days.days
      end
      time
    end

    # 计算两个日期之间 日差
    def self.get_days(from, to)
      (to - from).to_i / 1.days
    end

    # 计算两个日期之间 月差
    def self.get_months(from, to)
      (to.year - from.year)*12 + (to.month - from.month)
    end

    def self.numberic(value)
      value = value.to_f
      if (value / 100000000.0) >= 1
        return "#{(value / 100000000.0).numberfloor(2)}亿"
      elsif (value / 10000.0) >= 1
        return "#{(value / 10000.0).numberfloor(2)}万"
      else
        return "#{value.numberfloor(2)}元"
      end
    end

  end
end
