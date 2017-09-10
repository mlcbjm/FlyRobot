# coding: utf-8
module Omniknight
  module Utils

    def self.generate_code length=6
      a = [(0..9)].map{|i| i.to_a}.flatten
      (0...length).map{ a[rand(a.length)] }.join
    end

    def self.check_password password
      password = password.to_s
      password.length >= 6
    end

  end # utils
end # Omniknight
