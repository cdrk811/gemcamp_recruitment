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

ActiveRecord::Schema[7.0].define(version: 2023_03_24_055519) do
  create_table "applicants", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "batch_applicants", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "batch_id"
    t.bigint "applicant_id"
    t.string "status"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "interview_date"
    t.index ["applicant_id"], name: "fk_rails_12d30174f3"
    t.index ["batch_id", "applicant_id"], name: "index_batch_applicants_on_batch_id_and_applicant_id", unique: true
  end

  create_table "batches", charset: "utf8mb4", force: :cascade do |t|
    t.string "batch"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "call_logs", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "batch_applicant_id"
    t.datetime "interview_date"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_applicant_id"], name: "index_call_logs_on_batch_applicant_id"
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

  add_foreign_key "batch_applicants", "applicants"
  add_foreign_key "batch_applicants", "batches"
end
