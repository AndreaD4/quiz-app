class FirstMigration < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :host
      t.integer :users_count, default: 0
      t.integer :managers_count, default: 0
      t.timestamps
    end

    add_index :companies, :host, unique: true

    create_table :managers do |t|
      ## Devise
      t.belongs_to :companies, index: true, foreign_key: true
      t.string   :email,              null: false, default: ""
      t.string   :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      ## Profilo
      t.string :name, null: false

      t.timestamps null: false
    end
    add_index :managers, :email,                unique: true
    add_index :managers, :reset_password_token, unique: true

    create_table :game_rooms do |t|
      t.belongs_to :companies, index: true, foreign_key: true
      t.string :name, null: false
      t.integer :state, null: false, default: 0 # enum: not_started, in_progress, ended

      t.timestamps null: false
    end

    create_table :houses do |t|
      t.belongs_to :companies, index: true, foreign_key: true
      t.string :name, null: false

      t.timestamps null: false
    end

    create_table :players do |t|
      ## Devise
      t.belongs_to :companies, index: true, foreign_key: true
      t.string   :email,              null: false, default: ""
      t.string   :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      ## Profilo
      t.references :game_room, null: true, foreign_key: true, type: :bigint
      t.references :house,     null: true, foreign_key: true, type: :bigint
      t.string     :nickname,  null: false
      t.integer    :score,     null: false, default: 0

      t.timestamps null: false
    end

    add_index :players, :email,                unique: true
    add_index :players, :reset_password_token, unique: true

    create_table :questions do |t|
      t.references :game_room, null: false, foreign_key: true, type: :bigint
      t.text :content, null: false
      t.string :media_url
      t.jsonb :answers, null: false, default: {}
      t.string :correct_answer_key, null: false, limit: 1 # e.g. 'A', 'B', 'C', 'D'

      t.timestamps null: false
    end

    create_table :responses do |t|
      t.references :player, null: false, foreign_key: true, type: :bigint
      t.references :question, null: false, foreign_key: true, type: :bigint
      t.string :chosen_key, null: false, limit: 1 # user's choice key
      t.float :response_time, null: false # in seconds
      t.boolean :correct, null: false, default: false

      t.timestamps null: false
    end
  end
end
