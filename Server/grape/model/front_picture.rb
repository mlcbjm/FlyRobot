# -*- coding: utf-8 -*-

# 现金券相关类

module Omniknight
  module Model

    # 云存储管理的文件
    class CloudFile < ActiveRecord::Base
      # c_at is for happen time
# include Mongoid::Timestamps::Short

# field :file_name, type: String, default: "CF#{Time.now.to_i}"

# field :actual_url, type: String
      
    end # class CloudFile < ActiveRecord::Base


    # app首页用图片，admin中管理
    class FrontPicture < ActiveRecord::Base

      #是否设为使用为app的默认首页
# field :in_use, type: Boolean, default: false

    end #class FrontPicture < ActiveRecord::Base

    # 平台banner 
    class PlatformBannerPicture < ActiveRecord::Base

      # 宽度
# field :width, type: Integer, default: 200

      # 高度自动
# field :height, type: Integer# 

      belongs_to :platform

    end #class PlatformFrontPicture < ActiveRecord::Base


  end # module Model
end #module Omniknight
