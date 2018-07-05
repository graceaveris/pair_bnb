class Listing < ApplicationRecord
	validates :property_description, length: { maximum: 200 }
	belongs_to :user
end
