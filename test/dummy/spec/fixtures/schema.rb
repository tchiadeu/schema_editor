create_table "users", force: :cascade do |t|
  t.string "name"
  t.string "email"
  t.string "password"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end

create_table "posts", force: :cascade do |t|
  t.string "title"
  t.text "body"
  t.integer "user_id"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end

add_foreign_key "posts", "users"
