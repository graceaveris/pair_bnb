class Listing < ApplicationRecord
	validates :property_description, length: { maximum: 200 }
	belongs_to :user
	mount_uploaders :images, ImageUploader
end
