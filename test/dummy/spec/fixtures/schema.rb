add_foreign_key "posts", "users"

create_table "users", force: :cascade do |t|
  t.integer "id"
  t.string "name"
  t.string "email"
  t.string "password"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end
