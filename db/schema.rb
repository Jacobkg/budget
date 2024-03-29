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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121210052652) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.integer  "balance_in_cents", :default => 0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "budget_items", :force => true do |t|
    t.string   "category"
    t.integer  "amount_in_cents"
    t.string   "period"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "expenses", :force => true do |t|
    t.string   "description"
    t.integer  "amount_in_cents"
    t.date     "date"
    t.string   "category"
    t.string   "account"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "incomes", :force => true do |t|
    t.string   "description"
    t.integer  "amount_in_cents"
    t.date     "date"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "transfers", :force => true do |t|
    t.date     "date"
    t.string   "description"
    t.integer  "amount_in_cents"
    t.string   "source_account"
    t.string   "destination_account"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

end
