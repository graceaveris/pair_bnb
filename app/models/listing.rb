class Listing < ApplicationRecord
	validates :property_description, length: { maximum: 200 }
	has_many :reservations, dependent: :destroy
	belongs_to :user
	mount_uploaders :images, ImageUploader
end
