class Listing < ApplicationRecord
	validates :property_description, length: { maximum: 200 }
	has_many :reservations
	belongs_to :user
	mount_uploaders :images, ImageUploader
end
