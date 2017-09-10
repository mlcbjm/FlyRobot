# -*- coding: utf-8 -*-
module Omniknight
	module Model

		class Account < ActiveRecord::Base
			default_scope ->{ where(is_deleted: false) }
			
			before_save do |account|
				if account.c_at == '' || account.c_at.nil?
					account.c_at = Time.now()
				end
				account.u_at = Time.now()
			end

			def password
				return nil if self[:password].nil?
				@bcrypt_password = BCrypt::Password.new(self[:password]) if @bcrypt_password.nil?
				@bcrypt_password
			end

			def password= p
				@bcrypt_password = BCrypt::Password.create(p)
				self[:password] = @bcrypt_password.to_s
			end

			class << self

				def login(username, password, session = nil,team_id)
					d "try Login using username #{username}"
					account = Account.find_by(cname: username,team_id: team_id)
					if account
						if account.password == password
							d "login success"
							session.account = account if session
							account
						else
							w "password not match with #{password}"
							nil
						end
					else
						w "login failed: No account, username: #{username}"
						nil
					end
				end
			end
		end # class Account

		class AccountSession
			# used for cookie id and redis key
			attr_accessor :id
			attr_accessor :account_id
			# 是指向数据model，不会被打包，每次连接都用account_id去获取一次
			attr_accessor :account
			attr_accessor :created_at, :updated_at
			attr_accessor :last_url

			attr_accessor :rm_notify_date
			attr_accessor :arr_rm_earn_notify_ckind
			attr_accessor :arr_rm_limit_notify_asset_id

			# class method
			class << self
				def load_from_redis(key, redis)
					key = create_session_id if key.nil?
					session_data = redis[key]

					session = load(session_data)

					if session.nil?
						# key not exists or key is expired, recreate key
						session = self.new(create_session_id)
					end

					session
				end

				def create_session_id
					SecureRandom.uuid.delete("-")
				end

				def load(data)
					session = nil
					session = Oj.load(data) if data

					if session && session.account_id
						# p session
						account = Account.find(session.account_id)
						if (defined? BAC)
							if account
								d "Got account: `#{account.cname}`"
							else
								w "Missing account in session loading: `#{session.account_id}`"
							end # if account
						end# (defined? BAC) ?
						
						session.account = account if account
					else
						if (defined? BAC)
							w "Missing session by data: `#{data}`, session: `#{session}`"
						end # defined?bac
					end

					if session
						session.rm_notify_date ||= Date.today
						session.arr_rm_earn_notify_ckind ||= []
						session.arr_rm_limit_notify_asset_id ||= []
					end

					session
				end
			end
			# end class method

			def initialize _id
				@id = _id
				@account_id = ''
				@account = nil
				@last_url = '/'
				@updated_at = @created_at = Time.now

				@rm_notify_date ||= Date.today
				@arr_rm_earn_notify_ckind ||= []
				@arr_rm_limit_notify_asset_id ||= []
			end

			def dump
				# 重写oj的dump对象
				tmp = @account if @account
				@account = nil
				data = Oj.dump(self)
				@account = tmp if tmp
				data
			end

			def save_to_redis redis
				@updated_at = Time.now
				redis[@id] = dump
				redis.expire @id, 86400 * 30        # 一个月后session过期
			end

			def account=(_account)
				@account_id = _account.nil? ? nil : _account.id.to_s
				@account = _account
			end

			def account_signin(_account)
				self.account = _account
			end

			def account_signout
				self.account = nil
			end
		end # end class UserSession

	end # module Model
end # module Omniknight
