class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
    
    t.date :start_date
    t.date :end_date
    t.belongs_to :listing, index: true
    t.belongs_to :user, index: true
    t.timestamps
  
    end
  end
end