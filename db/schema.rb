# rubocop:disable all
ActiveRecord::Schema.define(version: 20171203175104) do
  enable_extension "plpgsql"

  create_table "forecast_requests", force: :cascade do |t|
    t.bigint "user_id"
    t.string "base_currency", limit: 3
    t.string "target_currency", limit: 3
    t.integer "amount"
    t.integer "waiting_time"
    t.string "stream_name"
    t.string "after"
    t.index ["user_id"], name: "index_forecast_requests_on_user_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.string "provider"
    t.string "base_currency", limit: 3
    t.datetime "date"
    t.jsonb "rates"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
