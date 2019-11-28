# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_27_222227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "champion_roles", force: :cascade do |t|
    t.bigint "champion_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["champion_id"], name: "index_champion_roles_on_champion_id"
    t.index ["role_id"], name: "index_champion_roles_on_role_id"
  end

  create_table "champions", force: :cascade do |t|
    t.string "name"
    t.string "api_id"
    t.string "image"
    t.string "blurb"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "lore"
    t.string "title"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "cost"
    t.string "tags"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.string "plaintext"
  end

  create_table "loadout_items", force: :cascade do |t|
    t.bigint "loadout_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_loadout_items_on_item_id"
    t.index ["loadout_id"], name: "index_loadout_items_on_loadout_id"
  end

  create_table "loadouts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "champion_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["champion_id"], name: "index_loadouts_on_champion_id"
    t.index ["user_id"], name: "index_loadouts_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stats", force: :cascade do |t|
    t.bigint "champion_id", null: false
    t.integer "hp"
    t.integer "hpperlevel"
    t.integer "mp"
    t.integer "mpperlevel"
    t.integer "movespeed"
    t.integer "armor"
    t.integer "armorperlevel"
    t.integer "spellblock"
    t.integer "spellblockperlevel"
    t.integer "attackrange"
    t.integer "hpregen"
    t.integer "hpregenperlevel"
    t.integer "mpregen"
    t.integer "mpregenperlevel"
    t.integer "crit"
    t.integer "critperlevel"
    t.integer "attackdamage"
    t.integer "attackdamageperlevel"
    t.integer "attackspeedperlevel"
    t.integer "attackspeed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["champion_id"], name: "index_stats_on_champion_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.string "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "champion_roles", "champions"
  add_foreign_key "champion_roles", "roles"
  add_foreign_key "loadout_items", "items"
  add_foreign_key "loadout_items", "loadouts"
  add_foreign_key "loadouts", "champions"
  add_foreign_key "loadouts", "users"
  add_foreign_key "stats", "champions"
end
