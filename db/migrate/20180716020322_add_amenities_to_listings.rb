class AddAmenitiesToListings < ActiveRecord::Migration[5.2]
  def change
  	add_column :listings, :amenities, :text, array:true, default: []
  end
end