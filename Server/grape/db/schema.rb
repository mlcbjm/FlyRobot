# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "accounts", force: :cascade do |t|
    t.string   "vname",                         limit: 255
    t.string   "cname",                         limit: 255
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.string   "password",                      limit: 255
    t.datetime "c_at"
    t.datetime "u_at"
    t.string   "email",                limit: 255
    t.integer   "role"
    t.integer   "team_id"
    t.string   "addr",                limit: 255
    t.string   "ename",                limit: 255
    t.string   "photo",                limit: 255
    t.string   "phone",                limit: 255
    t.string   "head_url",                limit: 255
  end

  add_index "accounts", ["vname"], name: "vname", using: :btree
  add_index "accounts", ["team_id"], name: "team_id", using: :btree
  
end
#for begin



ActiveRecord::Schema.define(version: 0) do

  create_table "teams", force: :cascade do |t|
    t.string   "vname",                         limit: 255
    t.string   "admin_cname",                         limit: 255
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.string   "admin_password",                      limit: 255
    t.datetime "c_at"
    t.datetime "u_at"
    t.string   "url_address",                limit: 255
    t.string   "number",                limit: 255
    t.boolean  "is_valid",                                                           default: true,  null: true
  end

  add_index "teams", ["vname"], name: "vname", using: :btree

  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "cleanings", force: :cascade do |t|
    t.string   "vname",                         limit: 255
    t.string   "ename",                         limit: 255
    t.string   "address",                         limit: 255
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.string   "contact",                      limit: 255
    t.datetime "c_at"
    t.datetime "u_at"
    t.string   "contact_address",                limit: 255
    t.string   "contact_address_ename",                limit: 255
    t.string   "contact_email",                limit: 255
    t.string   "contact_phone",                limit: 255
    t.string   "contact_tel",                limit: 255
    t.string   "number",                limit: 255
  end

  add_index "cleanings", ["vname"], name: "vname", using: :btree

  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "orders", force: :cascade do |t|
    t.string   "order_no",                         limit: 255
    t.integer   "order_type",                         limit: 4
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.integer   "status",                      limit: 4
    t.datetime "c_at"
    t.datetime "u_at"
    t.integer   "client_id",                limit: 4
    t.integer   "client_contact_id",                limit: 4
    t.integer   "service_id",                limit: 4
    t.integer   "box_division_id",                limit: 4
    t.string   "box_location",                limit: 255
    t.integer   "tank_id",                limit: 4
    t.integer   "c_by",                limit: 4
    t.integer   "cleaning_id",                limit: 4
    t.string   "pre_installed",                limit: 255
    t.datetime "start_at"
    t.datetime "finish_at"
    t.datetime "confirm_at"
    t.datetime "end_at"
    t.string   "last_cargo",                limit: 255
    t.string   "last_cargo_no",                limit: 255
    t.string   "next_cargo_no",                limit: 255
    t.string   "bottom_discharging",                limit: 255
    t.string   "serial_no",                limit: 255
    t.integer   "team_id",                limit: 4
    t.string   "client_no",                limit: 255
  end

  add_index "orders", ["order_no"], name: "order_no", using: :btree
  add_index "orders", ["tank_id"], name: "tank_id", using: :btree
  add_index "orders", ["cleaning_id"], name: "cleaning_id", using: :btree
  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "tanks", force: :cascade do |t|
    t.string   "customize_result",                limit: 255
    t.integer   "tare_weight",                limit: 4
    t.string   "tank_type",                limit: 255
    t.string   "tank_no",                limit: 255
    t.integer   "gross_weight",                limit: 4
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.integer   "capacity",                      limit: 4
    t.datetime "c_at"
    t.datetime "u_at"
    t.datetime   "manufacture_date"
  end

  add_index "tanks", ["tank_no"], name: "tank_no", using: :btree

  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "order_actions", force: :cascade do |t|
    t.string   "vname",                limit: 255
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.datetime "c_at"
    t.datetime "u_at"
    t.integer   "c_by",                limit: 4
    t.integer   "order_id",                      limit: 4
  end

  add_index "order_actions", ["order_id"], name: "order_id", using: :btree

  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "order_templates", force: :cascade do |t|
    t.string   "vname",                limit: 255
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.integer   "status",                      limit: 4
    t.datetime "c_at"
    t.datetime "u_at"
    t.integer   "order_type",                limit: 4
    t.boolean  "is_valid"
    t.integer   "team_id",                      limit: 4
  end

  add_index "order_templates", ["vname"], name: "vname", using: :btree

  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "order_template_lists", force: :cascade do |t|
    t.string   "vname",                limit: 255
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.integer   "status",                      limit: 4
    t.integer   "result_number",                      limit: 4
    t.datetime "c_at"
    t.datetime "u_at"
    t.integer   "input_type",                limit: 4
    t.boolean  "is_valid"
    t.integer   "order_template_id",                         limit: 4
    t.text    "customizes",             limit: 65535
  end

  add_index "order_template_lists", ["vname"], name: "vname", using: :btree

  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "order_customize_values", force: :cascade do |t|
    t.integer   "order_template_list_id",                         limit: 4
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.integer   "account_id",                      limit: 4
    t.datetime "c_at"
    t.datetime "u_at"
    t.string   "customize_result",                limit: 255
    t.integer   "order_id",                      limit: 4
  end

  add_index "order_customize_values", ["account_id"], name: "account_id", using: :btree
  add_index "order_customize_values", ["order_id"], name: "order_id", using: :btree
  add_index "order_customize_values", ["order_template_list_id"], name: "order_template_list_id", using: :btree
  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "clients", force: :cascade do |t|
    t.string   "vname",                limit: 255
    t.string   "address",                limit: 255
    t.string   "pname",                limit: 255
    t.string   "webaddr",                limit: 255
    t.string   "fax",                limit: 255
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.datetime "c_at"
    t.datetime "u_at"
    t.integer   "team_id",                limit: 4
  end

  add_index "clients", ["vname"], name: "vname", using: :btree

  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "client_contacts", force: :cascade do |t|
    t.string   "vname",                limit: 255
    t.string   "phone",                limit: 255
    t.string   "email",                limit: 255
    t.integer   "client_id",                         limit: 4
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.datetime "c_at"
    t.datetime "u_at"
  end

  add_index "client_contacts", ["client_id"], name: "client_id", using: :btree
  add_index "client_contacts", ["vname"], name: "vname", using: :btree
  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "cost_types", force: :cascade do |t|
    t.string   "vname",                limit: 255
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.datetime "c_at"
    t.datetime "u_at"
    t.boolean  "is_valid"
    t.integer   "team_id",                limit: 4
  end

  add_index "cost_types", ["vname"], name: "vname", using: :btree
  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "order_costs", force: :cascade do |t|
    t.string   "notes",                limit: 255
    t.integer   "client_id",                limit: 4
    t.integer   "order_id",                limit: 4
    t.integer   "cost_type_id",                limit: 4
    t.decimal  "pay_money",                      precision: 20, scale: 5, default: 0.0,      null: false
    t.integer   "month_cost_id",                         limit: 4
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.datetime "c_at"
    t.datetime "u_at"
    t.datetime "pay_time"
    t.integer   "c_by",                limit: 4
  end

  add_index "order_costs", ["cost_type_id"], name: "cost_type_id", using: :btree
  add_index "order_costs", ["client_id"], name: "client_id", using: :btree
  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "month_costs", force: :cascade do |t|
    t.datetime "pay_date"
    t.integer   "year",                limit: 4
    t.integer   "month",                limit: 4
    t.integer   "client_id",                limit: 4
    t.integer   "status",                      limit: 4
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.datetime "c_at"
    t.datetime "u_at"
    t.integer   "team_id",                limit: 4
    t.integer   "c_by",                limit: 4
    t.decimal  "total_pay_money",                      precision: 20, scale: 5, default: 0.0,      null: false
  end

  add_index "month_costs", ["year"], name: "year", using: :btree
  add_index "month_costs", ["month"], name: "month", using: :btree
  
end

ActiveRecord::Schema.define(version: 0) do

  create_table "order_files", force: :cascade do |t|
    t.string   "file_name",                limit: 255
    t.integer   "file_size",                limit: 4
    t.string   "file_url",                limit: 255
    t.string   "file_type",                limit: 255
    t.integer   "order_id",                limit: 4
    t.boolean  "is_deleted",                                                           default: false,  null: false
    t.datetime "c_at"
    t.datetime "u_at"
  end

  add_index "order_files", ["file_name"], name: "file_name", using: :btree
  add_index "order_files", ["order_id"], name: "order_id", using: :btree
  
end