
class CreateListings < ActiveRecord::Migration[5.2]
    def change
    create_table :listings do |t|
      
      t.string :property_name
      t.text :property_description
      t.integer :max_guest_number
      t.string :country
      t.string :city
      t.integer :price
      t.belongs_to :user, index: true
      
      t.timestamps
    end
end
end