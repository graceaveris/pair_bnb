class Listing < ApplicationRecord
	validates :property_description, length: { maximum: 200 }
	has_many :reservations, dependent: :destroy
	belongs_to :user
	mount_uploaders :images, ImageUploader

	scope :max_guest_scope, -> (max_guest_number) { where("max_guest_number >= ? ", max_guest_number) }
    scope :city_scope, -> (city) { where city: city }
    scope :price_range_scope, -> (min_price, max_price) { where("price >= ? AND price <= ?", min_price, max_price) }



    #OLD SCOPE FOR PROCE BRACKETS # scope :price_scope, -> (price.split(',')) { where(("price[0].to_i <= ?") && ("price[1].to_i >= ?"), price) }

end

