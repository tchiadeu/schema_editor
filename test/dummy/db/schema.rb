create_table "posts", force: :cascade do |t|
  t.integer "id"
  t.string "title"
  t.text "body"
  t.integer "user_id"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end
create_table "users", force: :cascade do |t|
  t.integer "id"
  t.string "name"
  t.string "email"
  t.string "password"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end

create_table "comments", force: :cascade do |t|
  t.integer "id"
  t.string "title"
  t.text "body"
  t.integer "post_id"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end
create_table "articles", force: :cascade do |t|
  t.integer "id"
  t.string "title"
  t.text "body"
  t.integer "user_id"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end
create_table "tests", force: :cascade do |t|
  t.integer "id"
  t.string "title"
  t.text "body"
  t.integer "user_id"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end

add_foreign_key "posts", "users"
add_foreign_key "comments", "posts"
add_foreign_key "articles", "users"
add_foreign_key "tests", "users"
