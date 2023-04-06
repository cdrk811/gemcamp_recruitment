# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_05_060017) do
  create_table "applicant_batch_ships", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "application_date"
    t.string "sourcing_channel"
    t.string "resume_link"
    t.bigint "applicant_id"
    t.bigint "batch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_applicant_batch_ships_on_applicant_id"
    t.index ["batch_id"], name: "index_applicant_batch_ships_on_batch_id"
  end

  create_table "applicants", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "batches", charset: "utf8mb4", force: :cascade do |t|
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "number"
  end

  create_table "call_logs", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "interview_date"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "interview_id"
    t.index ["interview_id"], name: "index_call_logs_on_interview_id"
  end

  create_table "gem_camps", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "pre_class_date"
    t.integer "letter_type", default: 0
    t.integer "signed_via", default: 0
    t.datetime "sent_at"
    t.datetime "reply_at"
    t.string "status"
    t.text "notes"
    t.bigint "applicant_batch_ship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_batch_ship_id"], name: "index_gem_camps_on_applicant_batch_ship_id"
  end

  create_table "interviews", charset: "utf8mb4", force: :cascade do |t|
    t.string "status"
    t.string "remarks"
    t.datetime "interview_date"
    t.bigint "applicant_batch_ship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_batch_ship_id"], name: "index_interviews_on_applicant_batch_ship_id"
  end

  create_table "pre_class_results", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "date_attended"
    t.string "repository"
    t.text "remarks"
    t.string "result"
    t.text "proctor_note"
    t.string "commute_duration"
    t.bigint "applicant_batch_ship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_batch_ship_id"], name: "index_pre_class_results_on_applicant_batch_ship_id"
  end

  create_table "pre_class_schedules", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "sent_at"
    t.datetime "reply_at"
    t.datetime "date"
    t.string "status"
    t.text "notes"
    t.bigint "applicant_batch_ship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_batch_ship_id"], name: "index_pre_class_schedules_on_applicant_batch_ship_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", null: false
    t.string "session_token"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "call_logs", "interviews"
end
