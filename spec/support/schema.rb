ActiveRecord::Schema.define do
  self.verbose = false

  create_table :addresses, :force => true do |t|
    t.string :street
    t.string :city
    t.string :state
    t.string :zip

    t.integer :user_id
    t.integer :property_id

    t.string :first_uuid
    t.string :second_uuid

    t.string :alpha_cats
    t.string :beta_cats

    t.timestamps null: false
  end

  add_index :addresses, :user_id
  add_index :addresses, :first_uuid
  add_index :addresses, :alpha_cats
end
