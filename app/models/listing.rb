class Listing < ApplicationRecord
	validates :property_description, length: { maximum: 200 }
	has_many :reservations, dependent: :destroy
	belongs_to :user
	mount_uploaders :images, ImageUploader
	

	scope :max_guest_scope, -> (max_guest_number) { where("max_guest_number >= ? ", max_guest_number) }
    scope :city_scope, -> (city) { where city: city }

end
