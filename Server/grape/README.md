# 运行
0. 安装 mysql, 并且创建好用户
1. bundle install
2. 编辑 config/config.rb 和 config/database.yml
3. rake db:setup
4. rake 就跑起来 server 了

# 开发
- 在开发期使用了 guard，不用重启 server 就可以应用改变, 包括 model 或者 utils
  （ 如果还需要监听文件，需要修改 Guardfile ）
- 关于返回值：
  - 系统级别的错误（如没有登陆），自定义 Error class(errors.rb)，在错误的地方 raise
  - 逻辑上的错误用 render_error(msg)
  - 正常的直接返回就可以值就可以
  - 前端收到的格式（不管是不是200，或是500）：

        {"status":{"success":false,"msg":"尚未登陆"},"data": '各个接口的返回值'}

- v1/entities 是 GrapeEntity 的类，用来格式化输出，类似原来的 entity.package
- 每个 url 都需要参数 access_params 里面包含 Client 的版本和 seesion_id
