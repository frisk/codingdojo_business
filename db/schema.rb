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

ActiveRecord::Schema.define(version: 20130918151814) do

  create_table "answers", force: true do |t|
    t.text     "content"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "response_id"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["response_id"], name: "index_answers_on_response_id"

  create_table "bootcamps", force: true do |t|
    t.string   "title"
    t.string   "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.text     "content"
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "rated",      default: false
    t.boolean  "txt_area",   default: false
  end

  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id"

  create_table "responses", force: true do |t|
    t.integer  "term"
    t.integer  "bootcamp_id"
    t.integer  "survey_id"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responses", ["bootcamp_id"], name: "index_responses_on_bootcamp_id"
  add_index "responses", ["staff_id"], name: "index_responses_on_staff_id"
  add_index "responses", ["survey_id"], name: "index_responses_on_survey_id"

  create_table "staffs", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
