ActiveRecord::Schema.define do
  self.verbose = false

  create_table :address, :force => true do |t|
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

  add_index :address, :user_id
  add_index :address, :first_uuid
  add_index :address, :alpha_cats
end
